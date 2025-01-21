import Foundation
import SwiftUI

struct Property: Identifiable, Hashable {
    let id: UUID
    let name: String
    let address: String
    let area: Double
    let rentalRate: Decimal
    let status: PropertyStatus
    let imageURL: String?
    let meters: [UtilityMeter]
    let utilities: [Utility]
    let repairs: [Repair]
    
    // Добавить:
    let maintenanceCosts: [MaintenanceCost]
    let utilityBills: [UtilityBill] // Квитанции ЖКХ
    let reservations: [Reservation] // Бронирования
    
    // Показания счетчиков
    var formattedArea: String {
        return String(format: "%.1f м²", area)
    }
    
    var formattedRentalRate: String {
        return String(format: "%.2f ₽/мес", NSDecimalNumber(decimal: rentalRate).doubleValue)
    }
    
    // Добавляем реализацию Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Property, rhs: Property) -> Bool {
        lhs.id == rhs.id
    }
    
    init(
        id: UUID = UUID(),
        name: String,
        address: String,
        area: Double,
        rentalRate: Decimal,
        status: PropertyStatus,
        imageURL: String? = nil,
        meters: [UtilityMeter] = [],
        utilities: [Utility] = [],
        repairs: [Repair] = [],
        maintenanceCosts: [MaintenanceCost] = [],
        utilityBills: [UtilityBill] = [],
        reservations: [Reservation] = []
    ) {
        self.id = id
        self.name = name
        self.address = address
        self.area = area
        self.rentalRate = rentalRate
        self.status = status
        self.imageURL = imageURL
        self.meters = meters
        self.utilities = utilities
        self.repairs = repairs
        self.maintenanceCosts = maintenanceCosts
        self.utilityBills = utilityBills
        self.reservations = reservations
    }
}

struct UtilityMeter: Identifiable, Hashable {
    let id: UUID
    let type: UtilityType
    let number: String
    let lastReading: Double
    let lastReadingDate: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UtilityMeter, rhs: UtilityMeter) -> Bool {
        lhs.id == rhs.id
    }
}

enum UtilityType: String, Hashable {
    case electricity = "electricity"
    case coldWater = "cold_water"    // Добавляем ХВС
    case hotWater = "hot_water"      // Добавляем ГВС
    case gas = "gas"
    case heating = "heating"
    
    var title: String {
        switch self {
        case .electricity: return "Электричество"
        case .coldWater: return "Холодная вода"
        case .hotWater: return "Горячая вода"
        case .gas: return "Газ"
        case .heating: return "Отопление"
        }
    }
}

struct Utility: Identifiable, Hashable {
    let id: UUID
    let type: UtilityType
    let provider: String
    let accountNumber: String
    let rate: Decimal
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Utility, rhs: Utility) -> Bool {
        lhs.id == rhs.id
    }
}

struct Repair: Identifiable, Hashable {
    let id: UUID
    let description: String
    let cost: Decimal
    let date: Date
    let status: RepairStatus
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Repair, rhs: Repair) -> Bool {
        lhs.id == rhs.id
    }
}

enum RepairStatus: String, Hashable {
    case planned = "planned"
    case inProgress = "in_progress"
    case completed = "completed"
    
    var title: String {
        switch self {
        case .planned: return "Запланирован"
        case .inProgress: return "В процессе"
        case .completed: return "Завершен"
        }
    }
}

enum PropertyStatus: String {
    case available = "available"
    case rented = "rented"
    case maintenance = "maintenance"
    
    var title: String {
        switch self {
        case .available:
            return "Свободен"
        case .rented:
            return "Сдан"
        case .maintenance:
            return "На ремонте"
        }
    }
    
    var color: Color {
        switch self {
        case .available:
            return .green
        case .rented:
            return .blue
        case .maintenance:
            return .orange
        }
    }
}

struct MaintenanceCost: Identifiable, Hashable {
    let id: UUID
    let date: Date
    let description: String
    let amount: Decimal
    let type: MaintenanceType
    let paidBy: MaintenancePayer
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MaintenanceCost, rhs: MaintenanceCost) -> Bool {
        lhs.id == rhs.id
    }
}

// Добавляем новые enum-ы
enum MaintenanceType: String {
    case repair = "repair"           // Ремонт
    case cleaning = "cleaning"       // Уборка
    case security = "security"       // Охрана
    case utility = "utility"         // Коммунальные услуги
    case other = "other"            // Прочее
    
    var title: String {
        switch self {
        case .repair: return "Ремонт"
        case .cleaning: return "Уборка"
        case .security: return "Охрана"
        case .utility: return "Коммунальные услуги"
        case .other: return "Прочее"
        }
    }
}

enum MaintenancePayer: String {
    case landlord = "landlord"     // Собственник
    case tenant = "tenant"         // Арендатор
    
    var title: String {
        switch self {
        case .landlord: return "Собственник"
        case .tenant: return "Арендатор"
        }
    }
}

// Квитанции ЖКХ
struct UtilityBill: Identifiable, Hashable {
    let id: UUID
    let date: Date
    let amount: Decimal
    let type: UtilityType
    let isPaid: Bool
    let paidDate: Date?
    let scanURL: String? // URL скана квитанции
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UtilityBill, rhs: UtilityBill) -> Bool {
        lhs.id == rhs.id
    }
}

// Бронирования помещения
struct Reservation: Identifiable, Hashable {
    let id: UUID
    let startDate: Date
    let endDate: Date
    let tenantId: UUID?  // Может быть nil если просто забронировано без арендатора
    let status: ReservationStatus
    let comment: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Reservation, rhs: Reservation) -> Bool {
        lhs.id == rhs.id
    }
}

enum ReservationStatus: String {
    case pending = "pending"       // Ожидает подтверждения
    case confirmed = "confirmed"   // Подтверждено
    case cancelled = "cancelled"   // Отменено
    
    var title: String {
        switch self {
        case .pending: return "Ожидает подтверждения"
        case .confirmed: return "Подтверждено"
        case .cancelled: return "Отменено"
        }
    }
    
    var color: Color {
        switch self {
        case .pending: return .orange
        case .confirmed: return .green
        case .cancelled: return .red
        }
    }
} 