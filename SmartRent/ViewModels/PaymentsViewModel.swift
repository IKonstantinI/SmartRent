import Foundation

@MainActor
class PaymentsViewModel: ObservableObject {
    @Published var payments: [Payment] = []
    @Published var isLoading = false
    @Published var error: String?
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        // Получаем тестовые договоры
        let contractsVM = ContractsViewModel()
        let contracts = contractsVM.contracts
        
        payments = [
            Payment(
                id: UUID(),
                contractId: contracts[0].id,
                amount: 50000,
                date: Date(),
                type: .rent,
                status: .paid,
                description: "Арендная плата за январь 2024"
            ),
            Payment(
                id: UUID(),
                contractId: contracts[0].id,
                amount: 15000,
                date: Date().addingTimeInterval(-86400 * 5),
                type: .utilities,
                status: .pending,
                description: "Коммунальные платежи за декабрь 2023"
            ),
            Payment(
                id: UUID(),
                contractId: contracts[1].id,
                amount: 100000,
                date: Date().addingTimeInterval(-86400 * 30),
                type: .deposit,
                status: .paid,
                description: "Депозит по договору"
            ),
            Payment(
                id: UUID(),
                contractId: contracts[1].id,
                amount: 25000,
                date: Date().addingTimeInterval(-86400 * 15),
                type: .maintenance,
                status: .overdue,
                description: "Ремонт системы отопления"
            )
        ]
    }
    
    func updatePayment(_ payment: Payment) {
        if let index = payments.firstIndex(where: { $0.id == payment.id }) {
            payments[index] = payment
        }
    }
    
    func deletePayment(_ payment: Payment) {
        payments.removeAll { $0.id == payment.id }
    }
}

extension PaymentsViewModel {
    static var preview: PaymentsViewModel {
        let viewModel = PaymentsViewModel()
        let contracts = ContractsViewModel().contracts
        
        viewModel.payments = [
            Payment(
                id: UUID(),
                contractId: contracts[0].id,
                amount: 50000,
                date: Date(),
                type: .rent,
                status: .pending,
                description: "Арендная плата за январь 2024"
            ),
            Payment(
                id: UUID(),
                contractId: contracts[1].id,
                amount: 5000,
                date: Date().addingTimeInterval(-86400 * 30),
                type: .utilities,
                status: .paid,
                description: "Коммунальные платежи за декабрь 2023"
            )
        ]
        return viewModel
    }
} 