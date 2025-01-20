import Foundation

struct Tenant: Identifiable, Hashable {
    let id: UUID
    let firstName: String
    let lastName: String
    let phone: String
    let email: String
    let passport: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    // Добавляем реализацию Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Tenant, rhs: Tenant) -> Bool {
        lhs.id == rhs.id
    }
}

struct ContactInfo: Hashable {
    let phone: String
    let email: String
    let contactPerson: String?
}

struct BankDetails: Hashable {
    let bankName: String
    let accountNumber: String
    let bik: String
    let correspondentAccount: String
}

struct TaxInfo: Hashable {
    let inn: String
    let kpp: String?  // Для юр. лиц
    let ogrn: String? // Для юр. лиц
    let ogrnip: String? // Для ИП
} 