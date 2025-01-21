import SwiftUI

struct PropertyDetailView: View {
    let property: Property
    @State private var showDeleteAlert = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var propertiesViewModel: PropertiesViewModel
    
    var body: some View {
        List {
            mainInfoSection
            addressSection
            utilitiesSection
            metersSection
            repairsSection
            maintenanceSection
            utilityBillsSection
            reservationsSection
            actionsSection
        }
        .navigationTitle("Объект недвижимости")
        .alert("Удалить объект?", isPresented: $showDeleteAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Удалить", role: .destructive) {
                propertiesViewModel.properties.removeAll { $0.id == property.id }
                dismiss()
            }
        } message: {
            Text("Это действие нельзя отменить")
        }
    }
    
    private var mainInfoSection: some View {
        Section("Основная информация") {
            InfoRow(title: "Название", value: property.name)
            InfoRow(title: "Площадь", value: property.formattedArea)
            InfoRow(title: "Арендная плата", value: property.formattedRentalRate)
            InfoRow(title: "Статус", value: property.status.title)
        }
    }
    
    private var addressSection: some View {
        Section("Адрес") {
            InfoRow(title: "Адрес", value: property.address)
        }
    }
    
    @ViewBuilder
    private var utilitiesSection: some View {
        if !property.utilities.isEmpty {
            Section("Коммунальные услуги") {
                ForEach(property.utilities) { utility in
                    VStack(alignment: .leading) {
                        Text(utility.type.title)
                            .font(.headline)
                        Text("Поставщик: \(utility.provider)")
                            .font(.subheadline)
                        Text("Лицевой счет: \(utility.accountNumber)")
                            .font(.caption)
                        Text("Тариф: \(String(format: "%.2f ₽", NSDecimalNumber(decimal: utility.rate).doubleValue))")
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var metersSection: some View {
        if !property.meters.isEmpty {
            Section("Счетчики") {
                ForEach(property.meters, id: \.id) { meter in
                    VStack(alignment: .leading) {
                        Text(meter.type.title)
                            .font(.headline)
                        Text("№ \(meter.number)")
                            .font(.subheadline)
                        Text("Последнее показание: \(String(format: "%.1f", meter.lastReading))")
                            .font(.caption)
                        Text("Дата: \(meter.lastReadingDate.formatted(.dateTime.day().month().year()))")
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var repairsSection: some View {
        if !property.repairs.isEmpty {
            Section("Ремонты") {
                ForEach(property.repairs, id: \.id) { repair in
                    VStack(alignment: .leading) {
                        Text(repair.description)
                            .font(.headline)
                        Text("Стоимость: \(String(format: "%.2f ₽", NSDecimalNumber(decimal: repair.cost).doubleValue))")
                            .font(.subheadline)
                        Text("Дата: \(repair.date.formatted(.dateTime.day().month().year()))")
                            .font(.caption)
                        Text("Статус: \(repair.status.title)")
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var maintenanceSection: some View {
        if !property.maintenanceCosts.isEmpty {
            Section("Расходы на обслуживание") {
                ForEach(property.maintenanceCosts, id: \.id) { cost in
                    VStack(alignment: .leading) {
                        Text(cost.description)
                            .font(.headline)
                        Text("Сумма: \(String(format: "%.2f ₽", NSDecimalNumber(decimal: cost.amount).doubleValue))")
                            .font(.subheadline)
                        Text("Тип: \(cost.type.title)")
                            .font(.caption)
                        Text("Оплачивает: \(cost.paidBy.title)")
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var utilityBillsSection: some View {
        if !property.utilityBills.isEmpty {
            Section("Квитанции ЖКХ") {
                ForEach(property.utilityBills, id: \.id) { bill in
                    VStack(alignment: .leading) {
                        Text(bill.type.title)
                            .font(.headline)
                        Text("Сумма: \(String(format: "%.2f ₽", NSDecimalNumber(decimal: bill.amount).doubleValue))")
                            .font(.subheadline)
                        Text("Дата: \(bill.date.formatted(.dateTime.day().month().year()))")
                            .font(.caption)
                        Text(bill.isPaid ? "Оплачено" : "Не оплачено")
                            .font(.caption)
                            .foregroundStyle(bill.isPaid ? Color.green : Color.red)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var reservationsSection: some View {
        if !property.reservations.isEmpty {
            Section("Бронирования") {
                ForEach(property.reservations, id: \.id) { reservation in
                    VStack(alignment: .leading) {
                        Text("\(reservation.startDate.formatted(.dateTime.day().month().year())) - \(reservation.endDate.formatted(.dateTime.day().month().year()))")
                            .font(.headline)
                        Text("Статус: \(reservation.status.title)")
                            .font(.subheadline)
                            .foregroundStyle(reservation.status.color)
                        if let comment = reservation.comment {
                            Text(comment)
                                .font(.caption)
                        }
                    }
                }
            }
        }
    }
    
    private var actionsSection: some View {
        Section("Действия") {
            Button(role: .destructive) {
                showDeleteAlert = true
            } label: {
                Label("Удалить объект", systemImage: "trash")
            }
        }
    }
}

#Preview {
    NavigationStack {
        PropertyDetailView(property: PropertiesViewModel().properties[0])
            .environmentObject(PropertiesViewModel())
    }
} 