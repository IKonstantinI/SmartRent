import Foundation
import Combine

@MainActor
class ContractFormViewModel: ObservableObject {
    @Published var number = ""
    @Published var startDate = Date()
    @Published var endDate = Date().addingTimeInterval(86400 * 365)
    @Published var rentalRate: Decimal = 0
    @Published var securityDeposit: Decimal = 0
    @Published var paymentDay = 5
    
    @Published var selectedPropertyId: UUID?
    @Published var selectedTenantId: UUID?
    
    @Published var includeElectricity = false
    @Published var includeWater = false
    @Published var includeHeating = false
    @Published var includeInternet = false
    @Published var includeCleaning = false
    @Published var additionalServices = ""
    
    @Published var properties: [Property] = []
    @Published var tenants: [Tenant] = []
    
    @Published var error: String?
    @Published var isSaving = false
    
    private var cancellables = Set<AnyCancellable>()
    private let contractsViewModel: ContractsViewModel
    let contract: RentalContract?
    
    var isValid: Bool {
        !number.isEmpty &&
        startDate < endDate &&
        rentalRate > 0 &&
        securityDeposit >= 0 &&
        selectedPropertyId != nil &&
        selectedTenantId != nil
    }
    
    init(contract: RentalContract? = nil, contractsViewModel: ContractsViewModel) {
        self.contract = contract
        self.contractsViewModel = contractsViewModel
        loadData()
        if let contract = contract {
            loadContract(contract)
        }
    }
    
    func loadData() {
        // TODO: Загрузка списка объектов и арендаторов
        properties = PropertiesViewModel().properties
        tenants = TenantsViewModel().tenants
    }
    
    private var selectedProperty: Property? {
        properties.first { $0.id == selectedPropertyId }
    }
    
    private var selectedTenant: Tenant? {
        tenants.first { $0.id == selectedTenantId }
    }
    
    func loadContract(_ contract: RentalContract) {
        number = contract.number
        startDate = contract.startDate
        endDate = contract.endDate
        rentalRate = contract.rentalRate
        securityDeposit = contract.securityDeposit
        paymentDay = contract.paymentDay
        
        selectedPropertyId = contract.property.id
        selectedTenantId = contract.tenant.id
        
        includeElectricity = contract.utilityPayments.includeElectricity
        includeWater = contract.utilityPayments.includeWater
        includeHeating = contract.utilityPayments.includeHeating
        includeInternet = contract.utilityPayments.includeInternet
        includeCleaning = contract.utilityPayments.includeCleaning
        additionalServices = contract.utilityPayments.additionalServices.joined(separator: ", ")
    }
    
    func save() {
        guard isValid,
              let property = selectedProperty,
              let tenant = selectedTenant else { return }
        
        let additionalServicesList = additionalServices
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        
        let utilityPayments = UtilityPayments(
            includeElectricity: includeElectricity,
            includeWater: includeWater,
            includeHeating: includeHeating,
            includeInternet: includeInternet,
            includeCleaning: includeCleaning,
            additionalServices: additionalServicesList
        )
        
        let newContract = RentalContract(
            id: contract?.id ?? UUID(),
            number: number,
            startDate: startDate,
            endDate: endDate,
            property: property,
            tenant: tenant,
            rentalRate: rentalRate,
            securityDeposit: securityDeposit,
            status: contract?.status ?? .draft,
            paymentDay: paymentDay,
            utilityPayments: utilityPayments
        )
        
        if contract == nil {
            contractsViewModel.contracts.append(newContract)
        } else {
            contractsViewModel.updateContract(newContract)
        }
    }
} 