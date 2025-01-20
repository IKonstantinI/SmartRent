import SwiftUI

struct ContractsView: View {
    @StateObject private var viewModel = ContractsViewModel()
    @State private var showNewContract = false
    @State private var searchText = ""
    
    var filteredContracts: [RentalContract] {
        if searchText.isEmpty {
            return viewModel.contracts
        }
        return viewModel.contracts.filter { contract in
            contract.tenant.fullName.localizedCaseInsensitiveContains(searchText) ||
            contract.property.name.localizedCaseInsensitiveContains(searchText) ||
            contract.number.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredContracts) { contract in
                    NavigationLink {
                        ContractDetailView(
                            contract: contract,
                            contractsViewModel: viewModel
                        )
                    } label: {
                        ContractRowView(contract: contract)
                    }
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

#Preview {
    ContractsView()
        .environmentObject(ContractsViewModel())
} 