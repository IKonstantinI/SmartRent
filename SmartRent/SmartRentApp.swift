import SwiftUI

@main
struct SmartRentApp: App {
    @StateObject private var propertiesViewModel = PropertiesViewModel()
    @StateObject private var tenantsViewModel = TenantsViewModel()
    @StateObject private var contractsViewModel = ContractsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(propertiesViewModel)
                .environmentObject(tenantsViewModel)
                .environmentObject(contractsViewModel)
        }
    }
} 