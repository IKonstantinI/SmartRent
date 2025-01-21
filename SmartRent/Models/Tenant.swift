import Foundation

struct Tenant: Identifiable, Hashable {
    let id: UUID
    let firstName: String
    let lastName: String
    let middleName: String
    let phone: String
    let email: String
    let passport: String
    let inn: String
    
    let bankDetails: BankDetails
    let taxInfo: TaxInfo
    let contactPerson: String?
    let type: TenantType // физ.лицо/юр.лицо/ИП
    
    var fullName: String {
        if middleName.isEmpty {
            return "\(firstName) \(lastName)"
        }
        return "\(firstName) \(middleName) \(lastName)"
    }
    
    // Добавляем реализацию Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Tenant, rhs: Tenant) -> Bool {
        lhs.id == rhs.id
    }
}

enum TenantType {
    case individual    // Физ. лицо
    case company      // Юр. лицо
    case entrepreneur // ИП
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