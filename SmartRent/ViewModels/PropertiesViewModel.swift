import Foundation
import Combine

class PropertiesViewModel: ObservableObject {
    @Published var properties: [Property] = []
    @Published var isLoading = false
    @Published var error: String?
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        // Счетчики для жилых помещений
        let residentialMeters = [
            UtilityMeter(
                id: UUID(),
                type: .electricity,
                number: "Э-12345678",
                lastReading: 1234.5,
                lastReadingDate: Date()
            ),
            UtilityMeter(
                id: UUID(),
                type: .water,
                number: "В-87654321",
                lastReading: 345.6,
                lastReadingDate: Date()
            ),
            UtilityMeter(
                id: UUID(),
                type: .gas,
                number: "Г-23456789",
                lastReading: 567.8,
                lastReadingDate: Date()
            )
        ]
        
        // Счетчики для коммерческих помещений
        let commercialMeters = [
            UtilityMeter(
                id: UUID(),
                type: .electricity,
                number: "ЭК-98765432",
                lastReading: 5678.9,
                lastReadingDate: Date()
            ),
            UtilityMeter(
                id: UUID(),
                type: .heating,
                number: "Т-34567890",
                lastReading: 789.0,
                lastReadingDate: Date()
            )
        ]
        
        // Коммунальные услуги для жилых помещений
        let residentialUtilities = [
            Utility(
                id: UUID(),
                type: .electricity,
                provider: "МосЭнергоСбыт",
                accountNumber: "123456789",
                rate: 5.47
            ),
            Utility(
                id: UUID(),
                type: .water,
                provider: "Мосводоканал",
                accountNumber: "987654321",
                rate: 35.12
            ),
            Utility(
                id: UUID(),
                type: .gas,
                provider: "Мосгаз",
                accountNumber: "456789123",
                rate: 7.23
            )
        ]
        
        // Коммунальные услуги для коммерческих помещений
        let commercialUtilities = [
            Utility(
                id: UUID(),
                type: .electricity,
                provider: "МосЭнергоСбыт",
                accountNumber: "К-123456789",
                rate: 7.82
            ),
            Utility(
                id: UUID(),
                type: .heating,
                provider: "МОЭК",
                accountNumber: "К-987654321",
                rate: 2543.17
            )
        ]
        
        // Текущие ремонты
        let currentRepairs = [
            Repair(
                id: UUID(),
                description: "Замена смесителя",
                cost: 2500,
                date: Date(),
                status: .completed
            ),
            Repair(
                id: UUID(),
                description: "Покраска стен",
                cost: 45000,
                date: Date().addingTimeInterval(86400 * 7),
                status: .planned
            )
        ]
        
        // Планируемые ремонты
        let plannedRepairs = [
            Repair(
                id: UUID(),
                description: "Замена окон",
                cost: 150000,
                date: Date().addingTimeInterval(86400 * 30),
                status: .planned
            ),
            Repair(
                id: UUID(),
                description: "Ремонт системы отопления",
                cost: 75000,
                date: Date().addingTimeInterval(86400 * 14),
                status: .inProgress
            )
        ]
        
        properties = [
            Property(
                id: UUID(),
                name: "2-к квартира на Ленина",
                address: "ул. Ленина, 12, кв. 45",
                area: 54.5,
                rentalRate: 35000,
                status: .available,
                imageURL: nil,
                meters: residentialMeters,
                utilities: residentialUtilities,
                repairs: currentRepairs
            ),
            Property(
                id: UUID(),
                name: "Офис на Мира",
                address: "пр. Мира, 25, офис 312",
                area: 62.0,
                rentalRate: 45000,
                status: .rented,
                imageURL: "https://images.unsplash.com/photo-1497366216548-37526070297c",
                meters: commercialMeters,
                utilities: commercialUtilities,
                repairs: []
            ),
            Property(
                id: UUID(),
                name: "Помещение на Гагарина",
                address: "ул. Гагарина, 15, помещение 12",
                area: 38.7,
                rentalRate: 28000,
                status: .maintenance,
                imageURL: "https://images.unsplash.com/photo-1497366811353-6870744d04b2",
                meters: commercialMeters,
                utilities: commercialUtilities,
                repairs: plannedRepairs
            ),
            Property(
                id: UUID(),
                name: "1-к квартира на Пушкина",
                address: "ул. Пушкина, 8, кв. 56",
                area: 51.3,
                rentalRate: 35000,
                status: .available,
                imageURL: "https://images.unsplash.com/photo-1493809842364-78817add7ffb",
                meters: residentialMeters,
                utilities: residentialUtilities,
                repairs: []
            ),
            Property(
                id: UUID(),
                name: "Офисное помещение на Победы",
                address: "пр. Победы, 120, офис 45",
                area: 85.2,
                rentalRate: 65000,
                status: .rented,
                imageURL: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688",
                meters: commercialMeters,
                utilities: commercialUtilities,
                repairs: []
            ),
            Property(
                id: UUID(),
                name: "Торговое помещение",
                address: "ул. Советская, 33, помещение 3",
                area: 95.0,
                rentalRate: 72000,
                status: .available,
                imageURL: "https://images.unsplash.com/photo-1556912998-c57cc6b63cd7",
                meters: commercialMeters,
                utilities: commercialUtilities,
                repairs: plannedRepairs
            ),
            Property(
                id: UUID(),
                name: "1-к квартира на Космонавтов",
                address: "ул. Космонавтов, 42, кв. 12",
                area: 42.8,
                rentalRate: 32000,
                status: .maintenance,
                imageURL: nil,
                meters: residentialMeters,
                utilities: residentialUtilities,
                repairs: currentRepairs
            ),
            Property(
                id: UUID(),
                name: "Офис в центре",
                address: "пр. Ленина, 78, офис 234",
                area: 73.5,
                rentalRate: 55000,
                status: .rented,
                imageURL: "https://images.unsplash.com/photo-1536376072261-38c75010e6c9",
                meters: commercialMeters,
                utilities: commercialUtilities,
                repairs: []
            )
        ]
    }
} 