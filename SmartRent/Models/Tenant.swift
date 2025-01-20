import Foundation

struct Tenant: Identifiable {
    let id: UUID
    let name: String
    let contacts: ContactInfo
    let bankDetails: BankDetails
    let taxInfo: TaxInfo
}

struct ContactInfo {
    let phone: String
    let email: String
    let contactPerson: String?
}

struct BankDetails {
    let bankName: String
    let accountNumber: String
    let bik: String
    let correspondentAccount: String
}

struct TaxInfo {
    let inn: String
    let kpp: String?  // Для юр. лиц
    let ogrn: String? // Для юр. лиц
    let ogrnip: String? // Для ИП
} 