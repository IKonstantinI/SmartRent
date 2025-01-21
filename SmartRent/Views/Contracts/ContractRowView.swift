import SwiftUI

struct ContractRowView: View {
    let contract: RentalContract
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("№ \(contract.number)")
                    .font(.headline)
                
                Spacer()
                
                StatusBadgeView(status: contract.status)
            }
            
            HStack {
                Text(contract.tenant.fullName)
                    .font(.subheadline)
                
                Spacer()
                
                Text(tenantTypeTitle)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(tenantTypeColor.opacity(0.2))
                    .foregroundStyle(tenantTypeColor)
                    .clipShape(Capsule())
            }
            
            Text(contract.property.name)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack {
                Text("\(dateFormatter.string(from: contract.startDate)) - \(dateFormatter.string(from: contract.endDate))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text(String(format: "%.2f ₽/мес", NSDecimalNumber(decimal: contract.rentalRate).doubleValue))
                    .font(.subheadline)
                    .bold()
            }
            
            if let contactPerson = contract.tenant.contactPerson {
                Text("Контактное лицо: \(contactPerson)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
    
    private var tenantTypeTitle: String {
        switch contract.tenant.type {
        case .individual:
            return "Физ. лицо"
        case .company:
            return "Юр. лицо"
        case .entrepreneur:
            return "ИП"
        }
    }
    
    private var tenantTypeColor: Color {
        switch contract.tenant.type {
        case .individual:
            return .blue
        case .company:
            return .purple
        case .entrepreneur:
            return .green
        }
    }
}

struct StatusBadgeView: View {
    let status: ContractStatus
    
    var body: some View {
        Text(status.title)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                status == .active ? Color.green.opacity(0.2) :
                status == .draft ? Color.gray.opacity(0.2) :
                status == .terminated ? Color.red.opacity(0.2) :
                Color.orange.opacity(0.2)
            )
            .foregroundStyle(
                status == .active ? Color.green :
                status == .draft ? Color.gray :
                status == .terminated ? Color.red :
                Color.orange
            )
            .clipShape(Capsule())
    }
}

#Preview {
    ContractRowView(contract: ContractsViewModel().contracts[0])
} 