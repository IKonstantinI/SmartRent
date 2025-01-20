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
                Section("Личные данные") {
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
                }
                
                Section("Документы") {
                    TextField("Паспорт", text: $viewModel.passport)
                    TextField("ИНН", text: $viewModel.inn)
                        .keyboardType(.numberPad)
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