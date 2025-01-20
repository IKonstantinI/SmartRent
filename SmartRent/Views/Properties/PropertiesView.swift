import SwiftUI

struct PropertiesView: View {
    @EnvironmentObject var viewModel: PropertiesViewModel
    @State private var searchText = ""
    
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
        NavigationStack {
            List(filteredProperties) { property in
                NavigationLink(destination: PropertyDetailView(property: property)) {
                    PropertyRowView(property: property)
                }
            }
            .navigationTitle("Объекты")
            .searchable(text: $searchText, prompt: "Поиск по адресу")
        }
    }
}

struct PropertyRowView: View {
    let property: Property
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(property.name)
                .font(.headline)
            
            Text(property.address)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack {
                Text(property.formattedArea)
                    .font(.subheadline)
                
                Spacer()
                
                Text(property.formattedRentalRate)
                    .font(.subheadline)
                    .bold()
            }
            
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
        .padding(.vertical, 4)
    }
}

#Preview {
    PropertiesView()
        .environmentObject(PropertiesViewModel())
} 