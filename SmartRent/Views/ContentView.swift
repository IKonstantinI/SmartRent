import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PropertiesView()
                .tabItem {
                    Label("Объекты", systemImage: "building.2")
                }
            
            TenantsView()
                .tabItem {
                    Label("Арендаторы", systemImage: "person.2")
                }
            
            ContractsView()
                .tabItem {
                    Label("Договоры", systemImage: "doc.text")
                }
            
            PaymentsView()
                .tabItem {
                    Label("Платежи", systemImage: "creditcard")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PropertiesViewModel())
        .environmentObject(TenantsViewModel())
        .environmentObject(ContractsViewModel())
} 