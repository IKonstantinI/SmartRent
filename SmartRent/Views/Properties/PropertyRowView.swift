import SwiftUI

struct PropertyRowView: View {
    let property: Property
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(property.name)
                    .font(.headline)
                
                Spacer()
                
                // Показываем статус бронирования, если есть активное
                if let activeReservation = property.reservations.first(where: { $0.status == .confirmed }) {
                    Text("Забронировано")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.orange.opacity(0.2))
                        .foregroundStyle(.orange)
                        .clipShape(Capsule())
                }
            }
            
            InfoRow(title: "Адрес", value: property.address)
            InfoRow(title: "Площадь", value: property.formattedArea)
            InfoRow(title: "Статус", value: property.status.title)
        }
    }
} 