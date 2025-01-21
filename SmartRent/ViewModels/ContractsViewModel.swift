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
        
        // Создаем тестовых арендаторов
        let individualTenant = Tenant(
            id: UUID(),
            firstName: "Иван",
            lastName: "Иванов",
            middleName: "Иванович",
            phone: "+7 (999) 123-45-67",
            email: "ivan@example.com",
            passport: "4444 555666",
            inn: "123456789012",
            bankDetails: BankDetails(
                bankName: "Сбербанк",
                accountNumber: "40817810099910004312",
                bik: "044525225",
                correspondentAccount: "30101810400000000225"
            ),
            taxInfo: TaxInfo(
                inn: "123456789012",
                kpp: nil,
                ogrn: nil,
                ogrnip: nil
            ),
            contactPerson: nil,
            type: .individual
        )
        
        let companyTenant = Tenant(
            id: UUID(),
            firstName: "ООО",
            lastName: "Ромашка",
            middleName: "",
            phone: "+7 (999) 765-43-21",
            email: "info@romashka.ru",
            passport: "",
            inn: "7701234567",
            bankDetails: BankDetails(
                bankName: "ВТБ",
                accountNumber: "40702810123450001234",
                bik: "044525745",
                correspondentAccount: "30101810345250000745"
            ),
            taxInfo: TaxInfo(
                inn: "7701234567",
                kpp: "770101001",
                ogrn: "1027700132195",
                ogrnip: nil
            ),
            contactPerson: "Петров Петр Петрович",
            type: .company
        )
        
        contracts = [
            RentalContract(
                id: UUID(),
                number: "2024-001",
                startDate: dateFormatter.date(from: "2024-01-01")!,
                endDate: dateFormatter.date(from: "2024-12-31")!,
                property: propertiesVM.properties[0],
                tenant: individualTenant,
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
                tenant: companyTenant,
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
    
    func updateContract(_ contract: RentalContract) {
        if let index = contracts.firstIndex(where: { $0.id == contract.id }) {
            contracts[index] = contract
        }
    }
    
    func deleteContract(_ contract: RentalContract) {
        contracts.removeAll { $0.id == contract.id }
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

extension ContractsViewModel {
    static var preview: ContractsViewModel {
        let viewModel = ContractsViewModel()
        let propertiesVM = PropertiesViewModel()
        
        // Используем тех же арендаторов, что и в основных данных
        let individualTenant = TenantsViewModel.preview.tenants[0]
        let companyTenant = TenantsViewModel.preview.tenants[1]
        
        viewModel.contracts = [
            RentalContract(
                id: UUID(),
                number: "2024-001",
                startDate: Date(),
                endDate: Date().addingTimeInterval(86400 * 365),
                property: propertiesVM.properties[0],
                tenant: individualTenant,
                rentalRate: 50000,
                securityDeposit: 50000,
                status: .active,
                paymentDay: 5,
                utilityPayments: UtilityPayments(
                    includeElectricity: true,
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
                startDate: Date().addingTimeInterval(-86400 * 365),
                endDate: Date(),
                property: propertiesVM.properties[1],
                tenant: companyTenant,
                rentalRate: 45000,
                securityDeposit: 45000,
                status: .terminated,
                paymentDay: 10,
                utilityPayments: UtilityPayments(
                    includeElectricity: false,
                    includeWater: true,
                    includeHeating: true,
                    includeInternet: false,
                    includeCleaning: false,
                    additionalServices: []
                )
            )
        ]
        return viewModel
    }
} 