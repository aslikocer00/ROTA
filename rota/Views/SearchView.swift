import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var store: PlaceStore
    @State private var searchText: String = ""
    @State private var selectedCategory: PlaceCategory? = nil
    @State private var selectedPrice: PriceLevel? = nil
    @State private var selectedArea: Area? = nil
    @State private var showFavoritesOnly = false

    private var filteredPlaces: [Place] {
        store.places.filter { place in
            (selectedCategory == nil || place.categories.contains(selectedCategory!)) &&
            (selectedPrice == nil || place.price == selectedPrice) &&
            (selectedArea == nil || place.area == selectedArea) &&
            (!showFavoritesOnly || store.isFavorite(place)) &&
            (searchText.isEmpty || place.matches(query: searchText))
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            header

            FilterBar(
                categories: PlaceCategory.allCases,
                selectedCategory: $selectedCategory,
                priceLevels: PriceLevel.allCases,
                selectedPrice: $selectedPrice,
                areas: Area.allCases,
                selectedArea: $selectedArea,
                showFavoritesOnly: $showFavoritesOnly
            )
            .padding(.horizontal)
            .padding(.bottom, 8)

            List {
                ForEach(filteredPlaces) { place in
                    NavigationLink(value: place) {
                        PlaceRow(place: place)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: filteredPlaces)
        }
        .navigationTitle("Keşfet")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Place.self) { place in
            PlaceDetailView(place: place)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Mekan, semt, mutfak ara", text: $searchText)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
            .padding(.horizontal)
            .padding(.top, 12)

            HStack {
                Text("Alanlar")
                    .font(.headline)
                Spacer()
                Text("Listeler")
                    .foregroundColor(.secondary)
                Text("Etiketler")
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
    }
}
