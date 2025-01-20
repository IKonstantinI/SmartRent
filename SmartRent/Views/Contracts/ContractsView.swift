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
            contract.tenant.fullName.localizedCaseInsensitiveContains(searchText) ||
            contract.tenant.phone.localizedCaseInsensitiveContains(searchText) ||
            contract.tenant.email.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredContracts) { contract in
                    NavigationLink(destination: ContractDetailView(contract: contract)) {
                        ContractRowView(contract: contract)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Поиск по номеру, объекту или арендатору")
            .navigationTitle("Договоры")
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