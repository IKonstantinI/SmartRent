import SwiftUI

struct ContractDetailView: View {
    @EnvironmentObject var contractsViewModel: ContractsViewModel
    let contract: RentalContract
    @State private var showTerminateAlert = false
    @State private var showActivateAlert = false
    @State private var isProcessing = false
    @State private var error: String?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        List {
            statusSection
            mainInfoSection
            propertySection
            tenantSection
            utilitySection
            actionsSection
        }
        .navigationTitle("Договор № \(contract.number)")
        .alert("Расторжение договора", isPresented: $showTerminateAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Расторгнуть", role: .destructive) {
                Task { await terminateContract() }
            }
        } message: {
            Text("Вы уверены, что хотите расторгнуть договор?")
        }
        .alert("Активация договора", isPresented: $showActivateAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Активировать") {
                Task { await activateContract() }
            }
        } message: {
            Text("Вы уверены, что хотите активировать договор?")
        }
        .alert("Ошибка", isPresented: .init(
            get: { error != nil },
            set: { if !$0 { error = nil } }
        )) {
            Button("OK") { error = nil }
        } message: {
            if let error = error {
                Text(error)
            }
        }
        .overlay {
            if isProcessing {
                ProgressView()
            }
        }
    }
    
    // MARK: - View Components
    
    private var statusSection: some View {
        Section {
            ContractStatusView(status: contract.status)
        }
    }
    
    private var mainInfoSection: some View {
        Section("Основная информация") {
            InfoRow(title: "Номер договора", value: contract.number)
            InfoRow(title: "Статус", value: contract.status.title)
            InfoRow(title: "Дата начала", value: dateFormatter.string(from: contract.startDate))
            InfoRow(title: "Дата окончания", value: dateFormatter.string(from: contract.endDate))
            InfoRow(title: "Арендная плата", value: String(format: "%.2f ₽/мес", NSDecimalNumber(decimal: contract.rentalRate).doubleValue))
            InfoRow(title: "Депозит", value: String(format: "%.2f ₽", NSDecimalNumber(decimal: contract.securityDeposit).doubleValue))
            InfoRow(title: "День оплаты", value: "\(contract.paymentDay)-е число")
        }
    }
    
    private var propertySection: some View {
        Section("Объект недвижимости") {
            NavigationLink {
                PropertyDetailView(property: contract.property)
            } label: {
                PropertyRowView(property: contract.property)
            }
        }
    }
    
    private var tenantSection: some View {
        Section("Арендатор") {
            NavigationLink {
                TenantDetailView(tenant: contract.tenant)
            } label: {
                TenantRowView(tenant: contract.tenant)
            }
        }
    }
    
    private var utilitySection: some View {
        Section("Коммунальные услуги") {
            UtilityPaymentsView(payments: contract.utilityPayments)
        }
    }
    
    private var actionsSection: some View {
        Section("Действия") {
            if contract.status == .draft {
                Button {
                    showActivateAlert = true
                } label: {
                    Label("Активировать договор", systemImage: "checkmark.circle")
                        .foregroundStyle(.green)
                }
                .disabled(isProcessing)
            }
            
            if contract.status == .active {
                Button(role: .destructive) {
                    showTerminateAlert = true
                } label: {
                    Label("Расторгнуть договор", systemImage: "xmark.circle")
                }
                .disabled(isProcessing)
            }
            
            Button {
                // TODO: Добавить экспорт в PDF
            } label: {
                Label("Экспорт в PDF", systemImage: "arrow.down.doc")
            }
        }
    }
    
    // MARK: - Actions
    
    private func terminateContract() async {
        isProcessing = true
        defer { isProcessing = false }
        
        do {
            try await contractsViewModel.terminateContract(contract)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func activateContract() async {
        isProcessing = true
        defer { isProcessing = false }
        
        do {
            try await contractsViewModel.activateContract(contract)
        } catch {
            self.error = error.localizedDescription
        }
    }
}

#Preview {
    NavigationStack {
        ContractDetailView(contract: ContractsViewModel().contracts[0])
    }
} 