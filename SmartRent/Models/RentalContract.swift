import Foundation

struct RentalContract: Identifiable {
    let id: UUID
    let number: String
    let startDate: Date
    let endDate: Date
    let property: Property
    let tenant: Tenant
    let rentalRate: Decimal
    let securityDeposit: Decimal
    var status: ContractStatus
    let paymentDay: Int // День месяца для оплаты
    let utilityPayments: UtilityPayments
    
    var isActive: Bool {
        let now = Date()
        return startDate <= now && now <= endDate && status == .active
    }
}

enum ContractStatus: String {
    case draft = "draft"
    case active = "active"
    case terminated = "terminated"
    case expired = "expired"
    
    var title: String {
        switch self {
        case .draft:
            return "Черновик"
        case .active:
            return "Активен"
        case .terminated:
            return "Расторгнут"
        case .expired:
            return "Истек"
        }
    }
}

struct UtilityPayments {
    let includeElectricity: Bool
    let includeWater: Bool
    let includeHeating: Bool
    let includeInternet: Bool
    let includeCleaning: Bool
    let additionalServices: [String]
} 