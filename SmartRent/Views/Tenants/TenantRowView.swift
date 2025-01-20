import SwiftUI

struct TenantRowView: View {
    let tenant: Tenant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            InfoRow(title: "ФИО", value: tenant.fullName)
            InfoRow(title: "Телефон", value: tenant.phone)
            InfoRow(title: "Email", value: tenant.email)
            InfoRow(title: "Паспорт", value: tenant.passport)
        }
    }
}

#Preview {
    TenantRowView(tenant: Tenant(
        id: UUID(),
        firstName: "Иван",
        lastName: "Иванов",
        phone: "+7 (999) 123-45-67",
        email: "ivanov@example.com",
        passport: "1234 567890"
    ))
} 