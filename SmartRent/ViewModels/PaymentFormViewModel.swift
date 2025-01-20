import Foundation

class PaymentFormViewModel: ObservableObject {
    @Published var selectedContractId: UUID?
    @Published var amount: Decimal = 0
    @Published var date = Date()
    @Published var type: PaymentType = .rent
    @Published var description: String = ""
    
    private let paymentsViewModel: PaymentsViewModel
    private let payment: Payment?
    
    var isValid: Bool {
        selectedContractId != nil && amount > 0
    }
    
    init(paymentsViewModel: PaymentsViewModel, payment: Payment? = nil) {
        self.paymentsViewModel = paymentsViewModel
        self.payment = payment
        
        if let payment = payment {
            selectedContractId = payment.contractId
            amount = payment.amount
            date = payment.date
            type = payment.type
            description = payment.description ?? ""
        }
    }
    
    func save() {
        guard let contractId = selectedContractId else { return }
        
        let newPayment = Payment(
            id: payment?.id ?? UUID(),
            contractId: contractId,
            amount: amount,
            date: date,
            type: type,
            status: .pending,
            description: description.isEmpty ? nil : description
        )
        
        // TODO: Добавить сохранение в базу данных
        // Пока просто добавляем в массив
        if payment == nil {
            paymentsViewModel.payments.append(newPayment)
        } else {
            if let index = paymentsViewModel.payments.firstIndex(where: { $0.id == payment?.id }) {
                paymentsViewModel.payments[index] = newPayment
            }
        }
    }
} 