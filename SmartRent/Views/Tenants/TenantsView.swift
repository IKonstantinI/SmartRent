import SwiftUI

struct TenantsView: View {
    @StateObject private var viewModel = TenantsViewModel()
    @State private var showNewTenant = false
    @State private var searchText = ""
    
    private var filteredTenants: [Tenant] {
        if searchText.isEmpty {
            return viewModel.tenants
        }
        return viewModel.tenants.filter { tenant in
            tenant.fullName.localizedCaseInsensitiveContains(searchText) ||
            tenant.phone.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredTenants) { tenant in
                    NavigationLink {
                        TenantDetailView(tenant: tenant, tenantsViewModel: viewModel)
                    } label: {
                        TenantRowView(tenant: tenant)
                    }
                }
            }
            .navigationTitle("Арендаторы")
            .searchable(text: $searchText, prompt: "Поиск по имени или телефону")
            .toolbar {
                Button {
                    showNewTenant = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showNewTenant) {
                TenantFormView(tenantsViewModel: viewModel)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TenantsView()
            .environmentObject(TenantsViewModel())
    }
} 