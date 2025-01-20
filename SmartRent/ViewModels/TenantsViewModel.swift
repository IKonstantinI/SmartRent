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
                inn: "123456789012"
            ),
            Tenant(
                id: UUID(),
                firstName: "Петр",
                lastName: "Петров",
                middleName: "Петрович",
                phone: "+7 (999) 765-43-21",
                email: "petr@example.com",
                passport: "7777 888999",
                inn: "987654321098"
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
                inn: "123456789012"
            ),
            Tenant(
                id: UUID(),
                firstName: "Петр",
                lastName: "Петров",
                middleName: "Петрович",
                phone: "+7 (999) 765-43-21",
                email: "petr@example.com",
                passport: "7777 888999",
                inn: "987654321098"
            )
        ]
        return viewModel
    }
} 