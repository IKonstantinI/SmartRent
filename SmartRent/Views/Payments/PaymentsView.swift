import SwiftUI

struct PaymentsView: View {
    @StateObject private var viewModel = PaymentsViewModel()
    @State private var searchText = ""
    @State private var showNewPayment = false
    
    var filteredPayments: [Payment] {
        if searchText.isEmpty {
            return viewModel.payments
        }
        return viewModel.payments.filter { payment in
            payment.description?.localizedCaseInsensitiveContains(searchText) ?? false ||
            payment.formattedAmount.localizedCaseInsensitiveContains(searchText) ||
            payment.type.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredPayments) { payment in
                    NavigationLink {
                        PaymentDetailView(payment: payment, paymentsViewModel: viewModel)
                    } label: {
                        PaymentRowView(payment: payment)
                    }
                }
            }
            .navigationTitle("Платежи")
            .searchable(text: $searchText, prompt: "Поиск по описанию или сумме")
            .toolbar {
                Button {
                    showNewPayment = true
                } label: {
                    Label("Новый платеж", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showNewPayment) {
                PaymentFormView(paymentsViewModel: viewModel)
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