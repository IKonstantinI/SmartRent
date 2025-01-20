import Foundation
import Combine

class TenantsViewModel: ObservableObject {
    @Published var tenants: [Tenant] = []
    @Published var isLoading = false
    @Published var error: String?
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        tenants = [
            Tenant(
                id: UUID(),
                name: "Иванов Иван Иванович",
                contacts: ContactInfo(
                    phone: "+7 (999) 123-45-67",
                    email: "ivanov@mail.ru",
                    contactPerson: nil
                ),
                bankDetails: BankDetails(
                    bankName: "Сбербанк",
                    accountNumber: "40817810123456789012",
                    bik: "044525225",
                    correspondentAccount: "30101810400000000225"
                ),
                taxInfo: TaxInfo(
                    inn: "771234567890",
                    kpp: nil,
                    ogrn: nil,
                    ogrnip: "321774600001234"
                )
            ),
            Tenant(
                id: UUID(),
                name: "ООО 'ТехноСтрой'",
                contacts: ContactInfo(
                    phone: "+7 (999) 234-56-78",
                    email: "info@technostroy.ru",
                    contactPerson: "Петров Петр Петрович"
                ),
                bankDetails: BankDetails(
                    bankName: "ВТБ",
                    accountNumber: "40702810987654321098",
                    bik: "044525745",
                    correspondentAccount: "30101810345250000745"
                ),
                taxInfo: TaxInfo(
                    inn: "7701234567",
                    kpp: "770101001",
                    ogrn: "1027700123456",
                    ogrnip: nil
                )
            ),
            Tenant(
                id: UUID(),
                name: "Сидоров Алексей Петрович",
                contacts: ContactInfo(
                    phone: "+7 (999) 456-78-90",
                    email: "sidorov@yandex.ru",
                    contactPerson: "Сидоров А.П."
                ),
                bankDetails: BankDetails(
                    bankName: "Альфа-Банк",
                    accountNumber: "40802810890123456789",
                    bik: "044525593",
                    correspondentAccount: "30101810200000000593"
                ),
                taxInfo: TaxInfo(
                    inn: "773123456789",
                    kpp: nil,
                    ogrn: nil,
                    ogrnip: "321774600009876"
                )
            ),
            Tenant(
                id: UUID(),
                name: "ИП Петрова М.С.",
                contacts: ContactInfo(
                    phone: "+7 (999) 567-89-01",
                    email: "petrova@gmail.com",
                    contactPerson: "Петрова Мария Сергеевна"
                ),
                bankDetails: BankDetails(
                    bankName: "Тинькофф",
                    accountNumber: "40802810900000123456",
                    bik: "044525974",
                    correspondentAccount: "30101810145250000974"
                ),
                taxInfo: TaxInfo(
                    inn: "772234567890",
                    kpp: nil,
                    ogrn: nil,
                    ogrnip: "321774600007654"
                )
            ),
            Tenant(
                id: UUID(),
                name: "ЗАО 'Инвест-Строй'",
                contacts: ContactInfo(
                    phone: "+7 (999) 678-90-12",
                    email: "info@invest-stroy.ru",
                    contactPerson: "Николаев Николай Николаевич"
                ),
                bankDetails: BankDetails(
                    bankName: "Райффайзен",
                    accountNumber: "40702810234567890123",
                    bik: "044525700",
                    correspondentAccount: "30101810200000000700"
                ),
                taxInfo: TaxInfo(
                    inn: "7702345678",
                    kpp: "770201001",
                    ogrn: "1027700009876",
                    ogrnip: nil
                )
            )
        ]
    }
} 