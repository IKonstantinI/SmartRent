import Foundation
import Combine

@MainActor
class ContractsViewModel: ObservableObject {
    @Published var contracts: [RentalContract] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        let propertiesVM = PropertiesViewModel()
        let tenantsVM = TenantsViewModel()
        
        guard let property = propertiesVM.properties.first,
              let tenant = tenantsVM.tenants.first else {
            return
        }
        
        contracts = [
            RentalContract(
                id: UUID(),
                number: "2024-001",
                startDate: dateFormatter.date(from: "2024-01-01")!,
                endDate: dateFormatter.date(from: "2024-12-31")!,
                property: property,
                tenant: tenant,
                rentalRate: 75000,
                securityDeposit: 75000,
                status: .active,
                paymentDay: 5,
                utilityPayments: UtilityPayments(
                    includeElectricity: false,
                    includeWater: true,
                    includeHeating: true,
                    includeInternet: false,
                    includeCleaning: false,
                    additionalServices: []
                )
            ),
            RentalContract(
                id: UUID(),
                number: "2023-015",
                startDate: dateFormatter.date(from: "2023-06-01")!,
                endDate: dateFormatter.date(from: "2024-05-31")!,
                property: propertiesVM.properties[1],
                tenant: tenantsVM.tenants[1],
                rentalRate: 120000,
                securityDeposit: 120000,
                status: .active,
                paymentDay: 10,
                utilityPayments: UtilityPayments(
                    includeElectricity: true,
                    includeWater: true,
                    includeHeating: true,
                    includeInternet: true,
                    includeCleaning: true,
                    additionalServices: ["Парковка"]
                )
            )
        ]
    }
    
    func saveContract(_ contract: RentalContract) async throws {
        // TODO: В будущем здесь будет сохранение в базу данных или на сервер
        contracts.append(contract)
    }
    
    func updateContract(_ contract: RentalContract) async throws {
        guard let index = contracts.firstIndex(where: { $0.id == contract.id }) else {
            throw ContractError.notFound
        }
        contracts[index] = contract
    }
    
    @MainActor
    func activateContract(_ contract: RentalContract) async throws {
        guard let index = contracts.firstIndex(where: { $0.id == contract.id }) else {
            throw ContractError.notFound
        }
        
        // Имитация задержки сети
        try? await Task.sleep(for: .seconds(1))
        
        // Обновляем статус договора
        contracts[index].status = .active
    }
    
    @MainActor
    func terminateContract(_ contract: RentalContract) async throws {
        guard let index = contracts.firstIndex(where: { $0.id == contract.id }) else {
            throw ContractError.notFound
        }
        
        // Имитация задержки сети
        try? await Task.sleep(for: .seconds(1))
        
        // Обновляем статус договора
        contracts[index].status = .terminated
    }
}

enum ContractError: LocalizedError {
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Договор не найден"
        }
    }
} 