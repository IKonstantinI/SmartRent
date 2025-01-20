import SwiftUI

struct PaymentFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: PaymentFormViewModel
    @EnvironmentObject var contractsViewModel: ContractsViewModel
    
    init(paymentsViewModel: PaymentsViewModel, payment: Payment? = nil) {
        _viewModel = StateObject(wrappedValue: PaymentFormViewModel(paymentsViewModel: paymentsViewModel, payment: payment))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Договор") {
                    Picker("Договор", selection: $viewModel.selectedContractId) {
                        Text("Выберите договор")
                            .tag(nil as UUID?)
                        ForEach(contractsViewModel.contracts) { contract in
                            Text("\(contract.number) - \(contract.tenant.fullName)")
                                .tag(contract.id as UUID?)
                        }
                    }
                }
                
                Section("Детали платежа") {
                    Picker("Тип платежа", selection: $viewModel.type) {
                        ForEach(PaymentType.allCases, id: \.self) { type in
                            Text(type.title)
                                .tag(type)
                        }
                    }
                    
                    TextField("Сумма", value: $viewModel.amount, format: .currency(code: "RUB"))
                        .keyboardType(.decimalPad)
                    
                    DatePicker("Дата",
                             selection: $viewModel.date,
                             displayedComponents: .date)
                }
                
                Section("Описание") {
                    TextField("Описание платежа", text: $viewModel.description, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Новый платеж")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarItems
            }
        }
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button("Отмена") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Сохранить") {
                    viewModel.save()
                    dismiss()
                }
                .disabled(!viewModel.isValid)
            }
        }
    }
}

#Preview {
    PaymentFormView(paymentsViewModel: PaymentsViewModel())
        .environmentObject(ContractsViewModel())
} 