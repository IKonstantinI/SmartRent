import SwiftUI

struct PaymentDetailView: View {
    let payment: Payment
    @ObservedObject var paymentsViewModel: PaymentsViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showEditSheet = false
    
    private var typeDescription: String {
        payment.type.title
    }
    
    private var statusDescription: String {
        payment.status.title
    }
    
    var body: some View {
        List {
            Section {
                InfoRow(title: "Сумма", value: payment.formattedAmount)
                InfoRow(title: "Дата", value: payment.date.formatted(date: .long, time: .omitted))
                InfoRow(title: "Тип", value: typeDescription)
                InfoRow(title: "Статус", value: statusDescription)
            } header: {
                Text("Основная информация")
            }
            
            if let description = payment.description, !description.isEmpty {
                Section {
                    Text(description)
                } header: {
                    Text("Комментарий")
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Платеж")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        showEditSheet = true
                    } label: {
                        Label("Редактировать", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                        paymentsViewModel.deletePayment(payment)
                        dismiss()
                    } label: {
                        Label("Удалить", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            PaymentFormView(paymentsViewModel: paymentsViewModel, payment: payment)
        }
    }
}

#Preview {
    NavigationStack {
        PaymentDetailView(
            payment: PaymentsViewModel.preview.payments[0],
            paymentsViewModel: PaymentsViewModel.preview
        )
    }
} 