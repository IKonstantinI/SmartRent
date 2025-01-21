import SwiftUI

struct TenantRowView: View {
    let tenant: Tenant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(tenant.fullName)
                    .font(.headline)
                
                Spacer()
                
                Text(typeTitle)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(typeColor.opacity(0.2))
                    .foregroundStyle(typeColor)
                    .clipShape(Capsule())
            }
            
            Text(tenant.phone)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let contactPerson = tenant.contactPerson {
                Text("Контактное лицо: \(contactPerson)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var typeTitle: String {
        switch tenant.type {
        case .individual:
            return "Физ. лицо"
        case .company:
            return "Юр. лицо"
        case .entrepreneur:
            return "ИП"
        }
    }
    
    private var typeColor: Color {
        switch tenant.type {
        case .individual:
            return .blue
        case .company:
            return .purple
        case .entrepreneur:
            return .green
        }
    }
}

#Preview {
    TenantRowView(tenant: Tenant(
        id: UUID(),
        firstName: "ООО",
        lastName: "Ромашка",
        middleName: "",
        phone: "+7 (999) 123-45-67",
        email: "info@romashka.ru",
        passport: "",
        inn: "7701234567",
        bankDetails: BankDetails(
            bankName: "Сбербанк",
            accountNumber: "40817810099910004312",
            bik: "044525225",
            correspondentAccount: "30101810400000000225"
        ),
        taxInfo: TaxInfo(
            inn: "7701234567",
            kpp: "770101001",
            ogrn: "1027700132195",
            ogrnip: nil
        ),
        contactPerson: "Петров Петр Петрович",
        type: .company
    ))
    .padding()
} 