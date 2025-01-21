import SwiftUI

struct PaymentDetailView: View {
    let payment: Payment
    @ObservedObject var paymentsViewModel: PaymentsViewModel
    @EnvironmentObject var contractsViewModel: ContractsViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showEditSheet = false
    
    private var contract: RentalContract? {
        contractsViewModel.contracts.first { $0.id == payment.contractId }
    }
    
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
            
            if let contract = contract {
                Section("Договор") {
                    NavigationLink {
                        ContractDetailView(
                            contract: contract,
                            contractsViewModel: contractsViewModel
                        )
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("№ \(contract.number)")
                                .font(.headline)
                            
                            HStack {
                                Text(contract.tenant.fullName)
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
                            
                            Text(contract.property.name)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
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
    NavigationStack {
        PaymentDetailView(
            payment: PaymentsViewModel.preview.payments[0],
            paymentsViewModel: PaymentsViewModel.preview
        )
    }
} 