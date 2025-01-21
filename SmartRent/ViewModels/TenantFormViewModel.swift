import Foundation
import SwiftUI

@MainActor
class TenantFormViewModel: ObservableObject {
    @Published var type: TenantType = .individual
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var middleName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var contactPerson = ""
    @Published var passport = ""
    
    // Банковские реквизиты
    @Published var bankName = ""
    @Published var accountNumber = ""
    @Published var bik = ""
    @Published var correspondentAccount = ""
    
    // Налоговые реквизиты
    @Published var inn = ""
    @Published var kpp = ""
    @Published var ogrn = ""
    @Published var ogrnip = ""
    
    private let tenantsViewModel: TenantsViewModel
    let tenant: Tenant?
    
    var isValid: Bool {
        !firstName.isEmpty && 
        !lastName.isEmpty && 
        !phone.isEmpty &&
        !bankName.isEmpty &&
        !accountNumber.isEmpty &&
        !bik.isEmpty &&
        !inn.isEmpty
    }
    
    init(tenantsViewModel: TenantsViewModel, tenant: Tenant? = nil) {
        self.tenantsViewModel = tenantsViewModel
        self.tenant = tenant
        
        if let tenant = tenant {
            type = tenant.type
            firstName = tenant.firstName
            lastName = tenant.lastName
            middleName = tenant.middleName
            phone = tenant.phone
            email = tenant.email
            contactPerson = tenant.contactPerson ?? ""
            passport = tenant.passport
            
            // Банковские реквизиты
            bankName = tenant.bankDetails.bankName
            accountNumber = tenant.bankDetails.accountNumber
            bik = tenant.bankDetails.bik
            correspondentAccount = tenant.bankDetails.correspondentAccount
            
            // Налоговые реквизиты
            inn = tenant.taxInfo.inn
            kpp = tenant.taxInfo.kpp ?? ""
            ogrn = tenant.taxInfo.ogrn ?? ""
            ogrnip = tenant.taxInfo.ogrnip ?? ""
        }
    }
    
    func save() {
        let bankDetails = BankDetails(
            bankName: bankName,
            accountNumber: accountNumber,
            bik: bik,
            correspondentAccount: correspondentAccount
        )
        
        let taxInfo = TaxInfo(
            inn: inn,
            kpp: type == .company ? kpp : nil,
            ogrn: type == .company ? ogrn : nil,
            ogrnip: type == .entrepreneur ? ogrnip : nil
        )
        
        let newTenant = Tenant(
            id: tenant?.id ?? UUID(),
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            phone: phone,
            email: email,
            passport: passport,
            inn: inn,
            bankDetails: bankDetails,
            taxInfo: taxInfo,
            contactPerson: contactPerson.isEmpty ? nil : contactPerson,
            type: type
        )
        
        if tenant == nil {
            tenantsViewModel.addTenant(newTenant)
        } else {
            tenantsViewModel.updateTenant(newTenant)
        }
    }
} 