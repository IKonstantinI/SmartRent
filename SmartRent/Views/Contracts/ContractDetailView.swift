import SwiftUI

struct ContractDetailView: View {
    let contract: RentalContract
    @State private var showTerminateAlert = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text(contract.status.title)
                        .font(.headline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            contract.status == .active ? Color.green.opacity(0.2) :
                            contract.status == .draft ? Color.gray.opacity(0.2) :
                            contract.status == .terminated ? Color.red.opacity(0.2) :
                            Color.orange.opacity(0.2)
                        )
                        .foregroundStyle(
                            contract.status == .active ? Color.green :
                            contract.status == .draft ? Color.gray :
                            contract.status == .terminated ? Color.red :
                            Color.orange
                        )
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    if contract.status == .active {
                        Button(role: .destructive) {
                            showTerminateAlert = true
                        } label: {
                            Label("Расторгнуть", systemImage: "xmark.circle")
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            
            Section("Основная информация") {
                InfoRow(title: "Номер договора", value: contract.number)
                InfoRow(title: "Статус", value: contract.status.title)
                InfoRow(title: "Дата начала", value: dateFormatter.string(from: contract.startDate))
                InfoRow(title: "Дата окончания", value: dateFormatter.string(from: contract.endDate))
                InfoRow(title: "Арендная плата", value: String(format: "%.2f ₽/мес", NSDecimalNumber(decimal: contract.rentalRate).doubleValue))
                InfoRow(title: "Депозит", value: String(format: "%.2f ₽", NSDecimalNumber(decimal: contract.securityDeposit).doubleValue))
                InfoRow(title: "День оплаты", value: "\(contract.paymentDay)-е число")
            }
            
            Section("Объект недвижимости") {
                NavigationLink {
                    PropertyDetailView(property: contract.property)
                } label: {
                    VStack(alignment: .leading) {
                        InfoRow(title: "Название", value: contract.property.name)
                        InfoRow(title: "Адрес", value: contract.property.address)
                        InfoRow(title: "Площадь", value: String(format: "%.1f м²", contract.property.area))
                    }
                }
            }
            
            Section("Арендатор") {
                NavigationLink {
                    TenantDetailView(tenant: contract.tenant)
                } label: {
                    VStack(alignment: .leading) {
                        InfoRow(title: "ФИО / Название", value: contract.tenant.name)
                        if let contactPerson = contract.tenant.contacts.contactPerson {
                            InfoRow(title: "Контактное лицо", value: contactPerson)
                        }
                        InfoRow(title: "Телефон", value: contract.tenant.contacts.phone)
                        InfoRow(title: "Email", value: contract.tenant.contacts.email)
                    }
                }
            }
            
            Section("Коммунальные услуги") {
                InfoRow(title: "Электричество", value: contract.utilityPayments.includeElectricity ? "Включено" : "Не включено")
                InfoRow(title: "Вода", value: contract.utilityPayments.includeWater ? "Включено" : "Не включено")
                InfoRow(title: "Отопление", value: contract.utilityPayments.includeHeating ? "Включено" : "Не включено")
                InfoRow(title: "Интернет", value: contract.utilityPayments.includeInternet ? "Включено" : "Не включено")
                InfoRow(title: "Уборка", value: contract.utilityPayments.includeCleaning ? "Включено" : "Не включено")
                
                if !contract.utilityPayments.additionalServices.isEmpty {
                    InfoRow(title: "Дополнительные услуги", value: contract.utilityPayments.additionalServices.joined(separator: ", "))
                }
            }
        }
        .navigationTitle("Договор № \(contract.number)")
        .alert("Расторжение договора", isPresented: $showTerminateAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Расторгнуть", role: .destructive) {
                // TODO: Добавить логику расторжения договора
            }
        } message: {
            Text("Вы уверены, что хотите расторгнуть договор? Это действие нельзя отменить.")
        }
        .toolbar {
            if contract.status == .draft {
                Button {
                    // TODO: Добавить логику активации договора
                } label: {
                    Label("Активировать", systemImage: "checkmark.circle")
                }
            }
            
            Menu {
                Button {
                    // TODO: Добавить логику печати
                } label: {
                    Label("Печать", systemImage: "printer")
                }
                
                Button {
                    // TODO: Добавить логику экспорта в PDF
                } label: {
                    Label("Экспорт в PDF", systemImage: "arrow.down.doc")
                }
            } label: {
                Label("Действия", systemImage: "ellipsis.circle")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContractDetailView(contract: ContractsViewModel().contracts[0])
    }
} 