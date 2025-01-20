import SwiftUI

struct TenantsView: View {
    @EnvironmentObject var viewModel: TenantsViewModel
    @State private var searchText = ""
    @State private var showNewTenant = false
    
    var filteredTenants: [Tenant] {
        if searchText.isEmpty {
            return viewModel.tenants
        }
        return viewModel.tenants.filter { tenant in
            tenant.fullName.localizedCaseInsensitiveContains(searchText) ||
            tenant.phone.localizedCaseInsensitiveContains(searchText) ||
            tenant.email.localizedCaseInsensitiveContains(searchText) ||
            tenant.passport.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredTenants) { tenant in
                NavigationLink(value: tenant) {
                    TenantRowView(tenant: tenant)
                }
            }
        }
        .navigationTitle("Арендаторы")
        .searchable(text: $searchText, prompt: "Поиск по ФИО или контактам")
        .toolbar {
            Button {
                showNewTenant = true
            } label: {
                Label("Новый арендатор", systemImage: "plus")
            }
        }
        .sheet(isPresented: $showNewTenant) {
            // TenantFormView будет добавлен позже
            Text("Форма добавления арендатора")
        }
    }
}

#Preview {
    NavigationStack {
        TenantsView()
            .environmentObject(TenantsViewModel())
    }
} 