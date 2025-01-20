import SwiftUI

struct TenantRowView: View {
    let tenant: Tenant
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(tenant.fullName)
                .font(.headline)
            Text(tenant.phone)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    TenantRowView(tenant: Tenant(
        id: UUID(),
        firstName: "Иван",
        lastName: "Иванов",
        middleName: "",
        phone: "+7 (999) 123-45-67",
        email: "ivanov@example.com",
        passport: "1234 567890",
        inn: "123456789012"
    ))
} 