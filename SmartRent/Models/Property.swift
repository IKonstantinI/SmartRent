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
    case water = "water"
    case gas = "gas"
    case heating = "heating"
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