import SwiftUI

struct PropertiesView: View {
    @EnvironmentObject var viewModel: PropertiesViewModel
    @State private var searchText = ""
    @State private var showNewProperty = false
    
    var filteredProperties: [Property] {
        if searchText.isEmpty {
            return viewModel.properties
        }
        return viewModel.properties.filter { property in
            property.name.localizedCaseInsensitiveContains(searchText) ||
            property.address.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredProperties) { property in
                NavigationLink(value: property) {
                    PropertyRowView(property: property)
                }
            }
        }
        .navigationTitle("Объекты")
        .searchable(text: $searchText, prompt: "Поиск по названию или адресу")
        .toolbar {
            Button {
                showNewProperty = true
            } label: {
                Label("Новый объект", systemImage: "plus")
            }
        }
        .sheet(isPresented: $showNewProperty) {
            // PropertyFormView будет добавлен позже
            Text("Форма добавления объекта")
        }
    }
}

#Preview {
    NavigationStack {
        PropertiesView()
            .environmentObject(PropertiesViewModel())
    }
} 