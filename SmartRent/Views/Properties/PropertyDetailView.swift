import SwiftUI

struct PropertyDetailView: View {
    let property: Property
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Основная информация
                Group {
                    Text(property.name)
                        .font(.title)
                        .bold()
                    
                    Text(property.address)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Text(property.status.title)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(property.status.color.opacity(0.2))
                            .foregroundStyle(property.status.color)
                            .clipShape(Capsule())
                        
                        Spacer()
                    }
                }
                
                Divider()
                
                // Характеристики
                Group {
                    Text("Характеристики")
                        .font(.headline)
                    
                    InfoRow(title: "Площадь", value: property.formattedArea)
                    InfoRow(title: "Арендная ставка", value: property.formattedRentalRate)
                }
                
                Divider()
                
                // Счетчики
                Group {
                    Text("Счетчики")
                        .font(.headline)
                    
                    ForEach(property.meters) { meter in
                        InfoRow(
                            title: meter.type.rawValue.capitalized,
                            value: "\(meter.lastReading) • \(meter.number)"
                        )
                    }
                }
                
                Divider()
                
                // Коммунальные услуги
                Group {
                    Text("Коммунальные услуги")
                        .font(.headline)
                    
                    ForEach(property.utilities) { utility in
                        InfoRow(
                            title: utility.type.rawValue.capitalized,
                            value: "\(utility.provider) • \(utility.accountNumber)"
                        )
                    }
                }
                
                if !property.repairs.isEmpty {
                    Divider()
                    
                    // Ремонты
                    Group {
                        Text("Ремонтные работы")
                            .font(.headline)
                        
                        ForEach(property.repairs) { repair in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(repair.description)
                                    .font(.subheadline)
                                
                                HStack {
                                    Text(String(format: "%.2f ₽", NSDecimalNumber(decimal: repair.cost).doubleValue))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                    
                                    Text(repair.status.rawValue.capitalized)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(
                                            repair.status == .completed ? Color.green.opacity(0.2) :
                                            repair.status == .inProgress ? Color.orange.opacity(0.2) :
                                            Color.blue.opacity(0.2)
                                        )
                                        .foregroundStyle(
                                            repair.status == .completed ? Color.green :
                                            repair.status == .inProgress ? Color.orange :
                                            Color.blue
                                        )
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PropertyDetailView(property: PropertiesViewModel().properties[0])
    }
} 