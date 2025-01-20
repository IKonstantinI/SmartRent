import SwiftUI

struct TenantDetailView: View {
    let tenant: Tenant
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Основная информация
                Group {
                    Text(tenant.name)
                        .font(.title)
                        .bold()
                    
                    if let contactPerson = tenant.contacts.contactPerson {
                        Text("Контактное лицо: \(contactPerson)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Divider()
                
                // Контакты
                Group {
                    Text("Контакты")
                        .font(.headline)
                    
                    InfoRow(title: "Телефон", value: tenant.contacts.phone)
                    InfoRow(title: "Email", value: tenant.contacts.email)
                }
                
                Divider()
                
                // Банковские реквизиты
                Group {
                    Text("Банковские реквизиты")
                        .font(.headline)
                    
                    InfoRow(title: "Банк", value: tenant.bankDetails.bankName)
                    InfoRow(title: "Расчетный счет", value: tenant.bankDetails.accountNumber)
                    InfoRow(title: "БИК", value: tenant.bankDetails.bik)
                    InfoRow(title: "Корр. счет", value: tenant.bankDetails.correspondentAccount)
                }
                
                Divider()
                
                // Налоговая информация
                Group {
                    Text("Налоговая информация")
                        .font(.headline)
                    
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