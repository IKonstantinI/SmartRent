import SwiftUI

struct PropertyRowView: View {
    let property: Property
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            InfoRow(title: "Название", value: property.name)
            InfoRow(title: "Адрес", value: property.address)
            InfoRow(title: "Площадь", value: String(format: "%.1f м²", property.area))
        }
    }
} 