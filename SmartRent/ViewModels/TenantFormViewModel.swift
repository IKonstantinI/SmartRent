import Foundation
import SwiftUI

@MainActor
class TenantFormViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var middleName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var passport = ""
    @Published var inn = ""
    
    private let tenantsViewModel: TenantsViewModel
    let tenant: Tenant?
    
    var isValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !phone.isEmpty
    }
    
    init(tenantsViewModel: TenantsViewModel, tenant: Tenant? = nil) {
        self.tenantsViewModel = tenantsViewModel
        self.tenant = tenant
        
        if let tenant = tenant {
            firstName = tenant.firstName
            lastName = tenant.lastName
            middleName = tenant.middleName
            phone = tenant.phone
            email = tenant.email
            passport = tenant.passport
            inn = tenant.inn
        }
    }
    
    func save() {
        let newTenant = Tenant(
            id: tenant?.id ?? UUID(),
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            phone: phone,
            email: email,
            passport: passport,
            inn: inn
        )
        
        if tenant == nil {
            tenantsViewModel.addTenant(newTenant)
        } else {
            tenantsViewModel.updateTenant(newTenant)
        }
    }
} 