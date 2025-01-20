import SwiftUI

struct ContractsView: View {
    @EnvironmentObject var viewModel: ContractsViewModel
    @State private var searchText = ""
    @State private var showNewContract = false
    
    var filteredContracts: [RentalContract] {
        if searchText.isEmpty {
            return viewModel.contracts
        }
        return viewModel.contracts.filter { contract in
            contract.number.localizedCaseInsensitiveContains(searchText) ||
            contract.property.name.localizedCaseInsensitiveContains(searchText) ||
            contract.tenant.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredContracts) { contract in
                NavigationLink(destination: ContractDetailView(contract: contract)) {
                    ContractRowView(contract: contract)
                }
            }
            .navigationTitle("Договоры")
            .searchable(text: $searchText, prompt: "Поиск по номеру или арендатору")
            .toolbar {
                Button {
                    showNewContract = true
                } label: {
                    Label("Новый договор", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showNewContract) {
                ContractFormView(contractsViewModel: viewModel)
            }
        }
    }
}

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
                Text(contract.status.title)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        contract.status == .active ? Color.green.opacity(0.2) :
                        contract.status == .draft ? Color.gray.opacity(0.2) :
                        contract.status == .terminated ? Color.red.opacity(0.2) :
                        Color.orange.opacity(0.2)
                    )
                    .foregroundStyle(
                        contract.status == .active ? Color.green :
                        contract.status == .draft ? Color.gray :
                        contract.status == .terminated ? Color.red :
                        Color.orange
                    )
                    .clipShape(Capsule())
            }
            
            Text(contract.tenant.name)
                .font(.subheadline)
            
            Text(contract.property.name)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
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

#Preview {
    ContractsView()
        .environmentObject(ContractsViewModel())
} 