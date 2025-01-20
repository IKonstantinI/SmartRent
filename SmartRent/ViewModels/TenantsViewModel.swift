import Foundation
import Combine

class TenantsViewModel: ObservableObject {
    @Published var tenants: [Tenant] = [
        Tenant(
            id: UUID(),
            firstName: "Иван",
            lastName: "Иванов",
            phone: "+7 (999) 123-45-67",
            email: "ivanov@example.com",
            passport: "1234 567890"
        ),
        Tenant(
            id: UUID(),
            firstName: "Петр",
            lastName: "Петров",
            phone: "+7 (999) 234-56-78",
            email: "petrov@example.com",
            passport: "4321 098765"
        ),
        Tenant(
            id: UUID(),
            firstName: "Алексей",
            lastName: "Сидоров",
            phone: "+7 (999) 345-67-89",
            email: "sidorov@example.com",
            passport: "5678 123456"
        ),
        Tenant(
            id: UUID(),
            firstName: "Мария",
            lastName: "Петрова",
            phone: "+7 (999) 456-78-90",
            email: "petrova@example.com",
            passport: "9876 543210"
        ),
        Tenant(
            id: UUID(),
            firstName: "Николай",
            lastName: "Николаев",
            phone: "+7 (999) 567-89-01",
            email: "nikolaev@example.com",
            passport: "2468 135790"
        )
    ]
    @Published var isLoading = false
    @Published var error: String?
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        // Данные уже загружены в инициализаторе массива tenants
    }
} 