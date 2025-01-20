import SwiftUI

struct TenantDetailView: View {
    let tenant: Tenant
    let tenantsViewModel: TenantsViewModel
    @State private var showEditSheet = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section("Личные данные") {
                InfoRow(title: "Имя", value: tenant.firstName)
                InfoRow(title: "Фамилия", value: tenant.lastName)
                if !tenant.middleName.isEmpty {
                    InfoRow(title: "Отчество", value: tenant.middleName)
                }
            }
            
            Section("Контакты") {
                InfoRow(title: "Телефон", value: tenant.phone)
                if !tenant.email.isEmpty {
                    InfoRow(title: "Email", value: tenant.email)
                }
            }
            
            Section("Документы") {
                if !tenant.passport.isEmpty {
                    InfoRow(title: "Паспорт", value: tenant.passport)
                }
                if !tenant.inn.isEmpty {
                    InfoRow(title: "ИНН", value: tenant.inn)
                }
            }
        }
        .navigationTitle("Арендатор")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        showEditSheet = true
                    } label: {
                        Label("Редактировать", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                        tenantsViewModel.deleteTenant(tenant)
                        dismiss()
                    } label: {
                        Label("Удалить", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            TenantFormView(tenantsViewModel: tenantsViewModel, tenant: tenant)
        }
    }
}

#Preview {
    NavigationStack {
        TenantDetailView(tenant: TenantsViewModel().tenants[0], tenantsViewModel: TenantsViewModel())
    }
} 