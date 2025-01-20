import SwiftUI

struct TenantsView: View {
    @EnvironmentObject var viewModel: TenantsViewModel
    @State private var searchText = ""
    
    var filteredTenants: [Tenant] {
        if searchText.isEmpty {
            return viewModel.tenants
        }
        return viewModel.tenants.filter { tenant in
            tenant.name.localizedCaseInsensitiveContains(searchText) ||
            tenant.contacts.phone.localizedCaseInsensitiveContains(searchText) ||
            tenant.contacts.email.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredTenants) { tenant in
                NavigationLink(destination: TenantDetailView(tenant: tenant)) {
                    TenantRowView(tenant: tenant)
                }
            }
            .navigationTitle("Арендаторы")
            .searchable(text: $searchText, prompt: "Поиск по имени или контактам")
        }
    }
}

struct TenantRowView: View {
    let tenant: Tenant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(tenant.name)
                .font(.headline)
            
            HStack {
                Label(tenant.contacts.phone, systemImage: "phone")
                Spacer()
                Label(tenant.contacts.email, systemImage: "envelope")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            if let contactPerson = tenant.contacts.contactPerson {
                Text("Контактное лицо: \(contactPerson)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TenantsView()
        .environmentObject(TenantsViewModel())
} 