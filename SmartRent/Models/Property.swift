import Foundation
import SwiftUI

struct Property: Identifiable {
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
}

struct UtilityMeter: Identifiable {
    let id: UUID
    let type: UtilityType
    let number: String
    let lastReading: Double
    let lastReadingDate: Date
}

enum UtilityType: String {
    case electricity = "electricity"
    case water = "water"
    case gas = "gas"
    case heating = "heating"
}

struct Utility: Identifiable {
    let id: UUID
    let type: UtilityType
    let provider: String
    let accountNumber: String
    let rate: Decimal
}

struct Repair: Identifiable {
    let id: UUID
    let description: String
    let cost: Decimal
    let date: Date
    let status: RepairStatus
}

enum RepairStatus: String {
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