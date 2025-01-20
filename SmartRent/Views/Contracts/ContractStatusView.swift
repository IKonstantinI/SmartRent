import SwiftUI

struct ContractStatusView: View {
    let status: ContractStatus
    
    var body: some View {
        Text(status.title)
            .font(.headline)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
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