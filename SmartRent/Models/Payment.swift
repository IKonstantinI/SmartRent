import Foundation
import SwiftUI

struct Payment: Identifiable, Hashable {
    let id: UUID
    let contractId: UUID
    let amount: Decimal
    let date: Date
    let type: PaymentType
    let status: PaymentStatus
    let description: String?
    
    // Вычисляемые свойства для форматирования
    var formattedAmount: String {
        String(format: "%.2f ₽", NSDecimalNumber(decimal: amount).doubleValue)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

enum PaymentType: String, Hashable, CaseIterable {
    case rent = "rent"
    case utilities = "utilities"
    case deposit = "deposit"
    case maintenance = "maintenance"
    
    var title: String {
        switch self {
        case .rent:
            return "Арендная плата"
        case .utilities:
            return "Коммунальные услуги"
        case .deposit:
            return "Депозит"
        case .maintenance:
            return "Обслуживание"
        }
    }
}

enum PaymentStatus: String, Hashable {
    case pending = "pending"
    case paid = "paid"
    case overdue = "overdue"
    case cancelled = "cancelled"
    
    var title: String {
        switch self {
        case .pending:
            return "Ожидает оплаты"
        case .paid:
            return "Оплачен"
        case .overdue:
            return "Просрочен"
        case .cancelled:
            return "Отменен"
        }
    }
    
    var color: Color {
        switch self {
        case .pending:
            return .orange
        case .paid:
            return .green
        case .overdue:
            return .red
        case .cancelled:
            return .gray
        }
    }
    
    var localizedName: String {
        switch self {
        case .pending:
            return "Ожидает оплаты"
        case .paid:
            return "Оплачен"
        case .overdue:
            return "Просрочен"
        case .cancelled:
            return "Отменен"
        }
    }
} 