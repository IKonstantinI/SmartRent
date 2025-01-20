import SwiftUI

struct ContractFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ContractFormViewModel
    
    let contract: RentalContract?
    let contractsViewModel: ContractsViewModel
    
    init(contract: RentalContract? = nil, contractsViewModel: ContractsViewModel) {
        self.contract = contract
        self.contractsViewModel = contractsViewModel
        _viewModel = StateObject(wrappedValue: ContractFormViewModel(contractsViewModel: contractsViewModel))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Основная информация") {
                    TextField("Номер договора", text: $viewModel.number)
                    
                    DatePicker("Дата начала",
                             selection: $viewModel.startDate,
                             displayedComponents: .date)
                    
                    DatePicker("Дата окончания",
                             selection: $viewModel.endDate,
                             displayedComponents: .date)
                    
                    TextField("Арендная плата", value: $viewModel.rentalRate, format: .currency(code: "RUB"))
                        .keyboardType(.decimalPad)
                    
                    TextField("Депозит", value: $viewModel.securityDeposit, format: .currency(code: "RUB"))
                        .keyboardType(.decimalPad)
                    
                    Stepper("День оплаты: \(viewModel.paymentDay)", value: $viewModel.paymentDay, in: 1...31)
                }
                
                Section("Объект недвижимости") {
                    Picker("Объект", selection: $viewModel.selectedPropertyId) {
                        ForEach(viewModel.properties) { property in
                            Text(property.name)
                                .tag(property.id)
                        }
                    }
                }
                
                Section("Арендатор") {
                    Picker("Арендатор", selection: $viewModel.selectedTenantId) {
                        ForEach(viewModel.tenants) { tenant in
                            Text(tenant.name)
                                .tag(tenant.id)
                        }
                    }
                }
                
                Section("Коммунальные услуги") {
                    Toggle("Электричество", isOn: $viewModel.includeElectricity)
                    Toggle("Вода", isOn: $viewModel.includeWater)
                    Toggle("Отопление", isOn: $viewModel.includeHeating)
                    Toggle("Интернет", isOn: $viewModel.includeInternet)
                    Toggle("Уборка", isOn: $viewModel.includeCleaning)
                    
                    TextField("Дополнительные услуги", text: $viewModel.additionalServices)
                }
            }
            .navigationTitle(contract == nil ? "Новый договор" : "Редактирование")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        Task {
                            await viewModel.save()
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.isValid)
                }
            }
            .onAppear {
                if let contract = contract {
                    viewModel.loadContract(contract)
                }
            }
        }
    }
}

#Preview {
    let viewModel = ContractsViewModel()
    return ContractFormView(contractsViewModel: viewModel)
} 