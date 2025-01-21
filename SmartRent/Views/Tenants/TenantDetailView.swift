import SwiftUI

struct TenantDetailView: View {
    let tenant: Tenant
    let tenantsViewModel: TenantsViewModel
    @State private var showEditSheet = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section("Личные данные") {
                InfoRow(title: "Тип", value: typeTitle)
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
                if let contactPerson = tenant.contactPerson {
                    InfoRow(title: "Контактное лицо", value: contactPerson)
                }
            }
            
            Section("Банковские реквизиты") {
                InfoRow(title: "Банк", value: tenant.bankDetails.bankName)
                InfoRow(title: "Расчетный счет", value: tenant.bankDetails.accountNumber)
                InfoRow(title: "БИК", value: tenant.bankDetails.bik)
                InfoRow(title: "Корр. счет", value: tenant.bankDetails.correspondentAccount)
            }
            
            Section("Налоговые реквизиты") {
                InfoRow(title: "ИНН", value: tenant.taxInfo.inn)
                if let kpp = tenant.taxInfo.kpp {
                    InfoRow(title: "КПП", value: kpp)
                }
                if let ogrn = tenant.taxInfo.ogrn {
                    InfoRow(title: "ОГРН", value: ogrn)
                }
                if let ogrnip = tenant.taxInfo.ogrnip {
                    InfoRow(title: "ОГРНИП", value: ogrnip)
                }
            }
            
            if !tenant.passport.isEmpty {
                Section("Паспортные данные") {
                    InfoRow(title: "Паспорт", value: tenant.passport)
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
    
    private var typeTitle: String {
        switch tenant.type {
        case .individual:
            return "Физическое лицо"
        case .company:
            return "Юридическое лицо"
        case .entrepreneur:
            return "ИП"
        }
    }
}

#Preview {
    NavigationStack {
        TenantDetailView(tenant: TenantsViewModel().tenants[0], tenantsViewModel: TenantsViewModel())
    }
} 