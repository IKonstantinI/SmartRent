import SwiftUI

struct PaymentsView: View {
    @StateObject private var paymentsViewModel = PaymentsViewModel()
    @State private var showAddPaymentSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(paymentsViewModel.payments) { payment in
                    NavigationLink {
                        PaymentDetailView(
                            payment: payment,
                            paymentsViewModel: paymentsViewModel
                        )
                    } label: {
                        PaymentRowView(payment: payment)
                    }
                }
            }
            .navigationTitle("Платежи")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddPaymentSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddPaymentSheet) {
                PaymentFormView(paymentsViewModel: paymentsViewModel)
            }
        }
    }
}

struct PaymentRowView: View {
    let payment: Payment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(payment.type.title)
                    .font(.headline)
                
                Spacer()
                
                Text(payment.formattedAmount)
                    .bold()
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
}

#Preview {
    NavigationStack {
        PaymentsView()
    }
} 