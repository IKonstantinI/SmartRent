import Foundation

class PaymentsViewModel: ObservableObject {
    @Published var payments: [Payment] = []
    @Published var isLoading = false
    @Published var error: String?
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        payments = [
            Payment(
                id: UUID(),
                contractId: UUID(),
                amount: 50000,
                date: Date(),
                type: .rent,
                status: .paid,
                description: "Арендная плата за январь 2024"
            ),
            Payment(
                id: UUID(),
                contractId: UUID(),
                amount: 15000,
                date: Date().addingTimeInterval(-86400 * 5),
                type: .utilities,
                status: .pending,
                description: "Коммунальные платежи за декабрь 2023"
            ),
            Payment(
                id: UUID(),
                contractId: UUID(),
                amount: 100000,
                date: Date().addingTimeInterval(-86400 * 30),
                type: .deposit,
                status: .paid,
                description: "Депозит по договору"
            ),
            Payment(
                id: UUID(),
                contractId: UUID(),
                amount: 25000,
                date: Date().addingTimeInterval(-86400 * 15),
                type: .maintenance,
                status: .overdue,
                description: "Ремонт системы отопления"
            )
        ]
    }
} 