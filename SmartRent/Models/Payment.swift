import Foundation

enum PaymentType: String, Codable {
    case rent = "rent"
    case utilities = "utilities"
    case deposit = "deposit"
}

enum PaymentStatus: String, Codable {
    case pending = "pending"
    case completed = "completed"
    case overdue = "overdue"
}

struct Payment: Identifiable, Codable {
    var id: String
    var tenantId: String
    var contractId: String
    var amount: Double
    var date: Date
    var type: PaymentType
    var status: PaymentStatus
} 