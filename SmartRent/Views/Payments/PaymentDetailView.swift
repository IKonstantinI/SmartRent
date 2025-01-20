import SwiftUI

struct PaymentDetailView: View {
    let payment: Payment
    @EnvironmentObject var contractsViewModel: ContractsViewModel
    @ObservedObject var paymentsViewModel: PaymentsViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showEditForm = false
    @State private var showDeleteAlert = false
    
    private var contract: RentalContract? {
        contractsViewModel.contracts.first { $0.id == payment.contractId }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Основная информация
                Group {
                    Text(payment.type.title)
                        .font(.title)
                        .bold()
                    
                    if let description = payment.description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Divider()
                
                // Детали платежа
                Group {
                    Text("Детали платежа")
                        .font(.headline)
                    
                    InfoRow(title: "Сумма", value: payment.formattedAmount)
                    InfoRow(title: "Дата", value: payment.formattedDate)
                    InfoRow(title: "Статус", value: payment.status.title)
                }
                
                Divider()
                
                // Информация о договоре
                if let contract = contract {
                    Group {
                        Text("Договор")
                            .font(.headline)
                        
                        NavigationLink(destination: ContractDetailView(contract: contract)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("№ \(contract.number)")
                                    .font(.subheadline)
                                    .bold()
                                
                                Text("\(contract.tenant.fullName) - \(contract.property.name)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Label("Удалить", systemImage: "trash")
                    }
                    
                    Button {
                        showEditForm = true
                    } label: {
                        Label("Редактировать", systemImage: "pencil")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showEditForm) {
            PaymentFormView(paymentsViewModel: paymentsViewModel, payment: payment)
        }
        .alert("Удалить платеж?", isPresented: $showDeleteAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Удалить", role: .destructive) {
                paymentsViewModel.deletePayment(payment)
                dismiss()
            }
        } message: {
            Text("Это действие нельзя отменить")
        }
    }
}

#Preview {
    NavigationStack {
        PaymentDetailView(
            payment: Payment(
                id: UUID(),
                contractId: UUID(),
                amount: 50000,
                date: Date(),
                type: .rent,
                status: .paid,
                description: "Арендная плата за январь 2024"
            ),
            paymentsViewModel: PaymentsViewModel()
        )
        .environmentObject(ContractsViewModel())
    }
} 