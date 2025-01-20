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
            
            NavigationLink(destination: TenantDetailView(tenant: contract.tenant)) {
                Text(contract.tenant.fullName)
                    .font(.subheadline)
            }
            
            NavigationLink(destination: PropertyDetailView(property: contract.property)) {
                Text(contract.property.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                Text("\(dateFormatter.string(from: contract.startDate)) - \(dateFormatter.string(from: contract.endDate))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text(String(format: "%.2f ₽/мес", NSDecimalNumber(decimal: contract.rentalRate).doubleValue))
                    .font(.subheadline)
                    .bold()
            }
        }
        .padding(.vertical, 4)
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