import SwiftUI

struct UtilityPaymentsView: View {
    let payments: UtilityPayments
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            InfoRow(title: "Электричество", value: payments.includeElectricity ? "Включено" : "Не включено")
            InfoRow(title: "Вода", value: payments.includeWater ? "Включено" : "Не включено")
            InfoRow(title: "Отопление", value: payments.includeHeating ? "Включено" : "Не включено")
            InfoRow(title: "Интернет", value: payments.includeInternet ? "Включено" : "Не включено")
            InfoRow(title: "Уборка", value: payments.includeCleaning ? "Включено" : "Не включено")
            
            if !payments.additionalServices.isEmpty {
                InfoRow(title: "Дополнительные услуги", value: payments.additionalServices.joined(separator: ", "))
            }
        }
    }
} 