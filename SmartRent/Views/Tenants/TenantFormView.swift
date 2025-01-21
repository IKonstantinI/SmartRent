import SwiftUI

struct TenantFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: TenantFormViewModel
    
    init(tenantsViewModel: TenantsViewModel, tenant: Tenant? = nil) {
        _viewModel = StateObject(wrappedValue: TenantFormViewModel(tenantsViewModel: tenantsViewModel, tenant: tenant))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Основная информация") {
                    Picker("Тип", selection: $viewModel.type) {
                        Text("Физическое лицо").tag(TenantType.individual)
                        Text("Юридическое лицо").tag(TenantType.company)
                        Text("ИП").tag(TenantType.entrepreneur)
                    }
                    
                    TextField("Имя", text: $viewModel.firstName)
                    TextField("Фамилия", text: $viewModel.lastName)
                    TextField("Отчество", text: $viewModel.middleName)
                }
                
                Section("Контакты") {
                    TextField("Телефон", text: $viewModel.phone)
                        .keyboardType(.phonePad)
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    TextField("Контактное лицо", text: $viewModel.contactPerson)
                }
                
                Section("Банковские реквизиты") {
                    TextField("Наименование банка", text: $viewModel.bankName)
                    TextField("Расчетный счет", text: $viewModel.accountNumber)
                        .keyboardType(.numberPad)
                    TextField("БИК", text: $viewModel.bik)
                        .keyboardType(.numberPad)
                    TextField("Корр. счет", text: $viewModel.correspondentAccount)
                        .keyboardType(.numberPad)
                }
                
                Section("Налоговые реквизиты") {
                    TextField("ИНН", text: $viewModel.inn)
                        .keyboardType(.numberPad)
                    if viewModel.type == .company {
                        TextField("КПП", text: $viewModel.kpp)
                            .keyboardType(.numberPad)
                        TextField("ОГРН", text: $viewModel.ogrn)
                            .keyboardType(.numberPad)
                    }
                    if viewModel.type == .entrepreneur {
                        TextField("ОГРНИП", text: $viewModel.ogrnip)
                            .keyboardType(.numberPad)
                    }
                }
                
                if viewModel.type == .individual {
                    Section("Паспортные данные") {
                        TextField("Паспорт", text: $viewModel.passport)
                    }
                }
            }
            .navigationTitle(viewModel.tenant == nil ? "Новый арендатор" : "Редактирование")
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