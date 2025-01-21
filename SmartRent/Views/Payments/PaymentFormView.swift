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
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(contract.number)")
                                    Text(contract.tenant.fullName)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Text(tenantTypeTitle(for: contract.tenant))
                                    .font(.caption)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(tenantTypeColor(for: contract.tenant).opacity(0.2))
                                    .foregroundStyle(tenantTypeColor(for: contract.tenant))
                                    .clipShape(Capsule())
                            }
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
    
    private func tenantTypeTitle(for tenant: Tenant) -> String {
        switch tenant.type {
        case .individual:
            return "Физ. лицо"
        case .company:
            return "Юр. лицо"
        case .entrepreneur:
            return "ИП"
        }
    }
    
    private func tenantTypeColor(for tenant: Tenant) -> Color {
        switch tenant.type {
        case .individual:
            return .blue
        case .company:
            return .purple
        case .entrepreneur:
            return .green
        }
    }
}

#Preview {
    PaymentFormView(paymentsViewModel: PaymentsViewModel())
        .environmentObject(ContractsViewModel())
} 