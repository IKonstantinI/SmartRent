import Foundation
import Combine

@MainActor
class TenantsViewModel: ObservableObject {
    @Published var tenants: [Tenant] = []
    @Published var isLoading = false
    @Published var error: String?
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        tenants = [
            Tenant(
                id: UUID(),
                firstName: "Иван",
                lastName: "Иванов",
                middleName: "Иванович",
                phone: "+7 (999) 123-45-67",
                email: "ivan@example.com",
                passport: "4444 555666",
                inn: "123456789012",
                bankDetails: BankDetails(
                    bankName: "Сбербанк",
                    accountNumber: "40817810099910004312",
                    bik: "044525225",
                    correspondentAccount: "30101810400000000225"
                ),
                taxInfo: TaxInfo(
                    inn: "123456789012",
                    kpp: nil,
                    ogrn: nil,
                    ogrnip: nil
                ),
                contactPerson: nil,
                type: .individual
            ),
            Tenant(
                id: UUID(),
                firstName: "ООО",
                lastName: "Ромашка",
                middleName: "",
                phone: "+7 (999) 765-43-21",
                email: "info@romashka.ru",
                passport: "",
                inn: "7701234567",
                bankDetails: BankDetails(
                    bankName: "ВТБ",
                    accountNumber: "40702810123450001234",
                    bik: "044525745",
                    correspondentAccount: "30101810345250000745"
                ),
                taxInfo: TaxInfo(
                    inn: "7701234567",
                    kpp: "770101001",
                    ogrn: "1027700132195",
                    ogrnip: nil
                ),
                contactPerson: "Петров Петр Петрович",
                type: .company
            )
        ]
    }
    
    func addTenant(_ tenant: Tenant) {
        tenants.append(tenant)
    }
    
    func updateTenant(_ tenant: Tenant) {
        if let index = tenants.firstIndex(where: { $0.id == tenant.id }) {
            tenants[index] = tenant
        }
    }
    
    func deleteTenant(_ tenant: Tenant) {
        tenants.removeAll { $0.id == tenant.id }
    }
}

extension TenantsViewModel {
    static var preview: TenantsViewModel {
        let viewModel = TenantsViewModel()
        viewModel.tenants = [
            Tenant(
                id: UUID(),
                firstName: "Иван",
                lastName: "Иванов",
                middleName: "Иванович",
                phone: "+7 (999) 123-45-67",
                email: "ivan@example.com",
                passport: "4444 555666",
                inn: "123456789012",
                bankDetails: BankDetails(
                    bankName: "Сбербанк",
                    accountNumber: "40817810099910004312",
                    bik: "044525225",
                    correspondentAccount: "30101810400000000225"
                ),
                taxInfo: TaxInfo(
                    inn: "123456789012",
                    kpp: nil,
                    ogrn: nil,
                    ogrnip: nil
                ),
                contactPerson: nil,
                type: .individual
            ),
            Tenant(
                id: UUID(),
                firstName: "ООО",
                lastName: "Ромашка",
                middleName: "",
                phone: "+7 (999) 765-43-21",
                email: "info@romashka.ru",
                passport: "",
                inn: "7701234567",
                bankDetails: BankDetails(
                    bankName: "ВТБ",
                    accountNumber: "40702810123450001234",
                    bik: "044525745",
                    correspondentAccount: "30101810345250000745"
                ),
                taxInfo: TaxInfo(
                    inn: "7701234567",
                    kpp: "770101001",
                    ogrn: "1027700132195",
                    ogrnip: nil
                ),
                contactPerson: "Петров Петр Петрович",
                type: .company
            )
        ]
        return viewModel
    }
} 