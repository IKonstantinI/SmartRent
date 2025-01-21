import SwiftUI

struct PaymentRowView: View {
    let payment: Payment
    @EnvironmentObject var contractsViewModel: ContractsViewModel
    
    private var contract: RentalContract? {
        contractsViewModel.contracts.first { $0.id == payment.contractId }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(payment.type.title)
                    .font(.headline)
                
                Spacer()
                
                Text(payment.formattedAmount)
                    .bold()
            }
            
            if let contract = contract {
                HStack {
                    Text("Договор № \(contract.number)")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text(tenantTypeTitle(for: contract.tenant))
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(tenantTypeColor(for: contract.tenant).opacity(0.2))
                        .foregroundStyle(tenantTypeColor(for: contract.tenant))
                        .clipShape(Capsule())
                }
                
                Text(contract.tenant.fullName)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            if let description = payment.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                Text(payment.formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text(payment.status.title)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(payment.status.color.opacity(0.2))
                    .foregroundStyle(payment.status.color)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 4)
    }
    
    private func tenantTypeTitle(for tenant: Tenant) -> String {
        switch tenant.type {
        case .individual:
            return "Физ. лицо"
        case .company:
            return "Юр. лицо"
        case .entrepreneur:
            return "ИП"
        }
    }
    
    private func tenantTypeColor(for tenant: Tenant) -> Color {
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
    let payment = PaymentsViewModel.preview.payments[0]
    return PaymentRowView(payment: payment)
        .environmentObject(ContractsViewModel())
        .padding()
} 