import SwiftUI

struct TenantDetailView: View {
    let tenant: Tenant
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Основная информация
                Group {
                    Text(tenant.fullName)
                        .font(.title)
                        .bold()
                }
                
                Divider()
                
                // Контакты
                Group {
                    Text("Контакты")
                        .font(.headline)
                    
                    InfoRow(title: "Телефон", value: tenant.phone)
                    InfoRow(title: "Email", value: tenant.email)
                }
                
                Divider()
                
                // Паспортные данные
                Group {
                    Text("Паспортные данные")
                        .font(.headline)
                    
                    InfoRow(title: "Серия и номер", value: tenant.passport)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TenantDetailView(tenant: TenantsViewModel().tenants[0])
    }
} 