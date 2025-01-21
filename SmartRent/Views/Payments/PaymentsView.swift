import SwiftUI

struct PaymentsView: View {
    @StateObject private var paymentsViewModel = PaymentsViewModel()
    @EnvironmentObject var contractsViewModel: ContractsViewModel
    @State private var showAddPaymentSheet = false
    @State private var selectedFilter: PaymentFilter = .all
    
    private var filteredPayments: [Payment] {
        switch selectedFilter {
        case .all:
            return paymentsViewModel.payments
        case .pending:
            return paymentsViewModel.payments.filter { $0.status == .pending }
        case .overdue:
            return paymentsViewModel.payments.filter { $0.status == .overdue }
        case .paid:
            return paymentsViewModel.payments.filter { $0.status == .paid }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Фильтр платежей
                Picker("Фильтр", selection: $selectedFilter) {
                    ForEach(PaymentFilter.allCases, id: \.self) { filter in
                        Text(filter.title)
                            .tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                List {
                    ForEach(filteredPayments) { payment in
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

enum PaymentFilter: String, CaseIterable {
    case all
    case pending
    case overdue
    case paid
    
    var title: String {
        switch self {
        case .all:
            return "Все"
        case .pending:
            return "Ожидают"
        case .overdue:
            return "Просрочены"
        case .paid:
            return "Оплачены"
        }
    }
}

#Preview {
    PaymentsView()
        .environmentObject(ContractsViewModel())
} 