import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var store: PlaceStore
    @State private var searchText: String = ""
    @State private var selectedCategory: PlaceCategory? = nil
    @State private var selectedPrice: PriceLevel? = nil
    @State private var selectedArea: Area? = nil
    @State private var showFavoritesOnly = false
    @State private var selectedSection: ExploreSection = .areas

    var body: some View {
        VStack(spacing: 0) {
            header

            TabView(selection: $selectedSection) {
                AreasPageView(
                    searchText: searchText,
                    selectedCategory: $selectedCategory,
                    selectedPrice: $selectedPrice,
                    selectedArea: $selectedArea,
                    showFavoritesOnly: $showFavoritesOnly
                )
                .tag(ExploreSection.areas)

                ListsPageView()
                    .tag(ExploreSection.lists)

                TagsPageView()
                    .tag(ExploreSection.tags)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.easeInOut, value: selectedSection)
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

            HStack(spacing: 12) {
                ForEach(ExploreSection.allCases) { section in
                    Button {
                        withAnimation(.easeInOut) {
                            selectedSection = section
                        }
                    } label: {
                        Text(section.title)
                            .font(.subheadline.weight(selectedSection == section ? .semibold : .regular))
                            .foregroundColor(selectedSection == section ? .primary : .secondary)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(
                                Capsule()
                                    .fill(selectedSection == section ? Color(.secondarySystemBackground) : .clear)
                            )
                    }
                    .buttonStyle(.plain)
                }

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

private enum ExploreSection: Int, CaseIterable, Identifiable {
    case areas
    case lists
    case tags

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .areas:
            return "Alanlar"
        case .lists:
            return "Listeler"
        case .tags:
            return "Etiketler"
        }
    }
}

private struct AreasPageView: View {
    @EnvironmentObject private var store: PlaceStore
    let searchText: String
    @Binding var selectedCategory: PlaceCategory?
    @Binding var selectedPrice: PriceLevel?
    @Binding var selectedArea: Area?
    @Binding var showFavoritesOnly: Bool

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
        List {
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
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)

            ForEach(filteredPlaces) { place in
                NavigationLink(value: place) {
                    PlaceRow(place: place)
                }
            }
        }
        .listStyle(.insetGrouped)
        .animation(.easeInOut, value: filteredPlaces)
    }
}

private struct ListsPageView: View {
    @EnvironmentObject private var store: PlaceStore

    private var featured: [Place] {
        store.places.filter { $0.isFeatured }
    }

    private var openings: [Place] {
        store.places.filter { !$0.isFeatured }
    }

    var body: some View {
        List {
            Section("Trend İstanbul") {
                ForEach(featured) { place in
                    NavigationLink(value: place) {
                        PlaceRow(place: place)
                    }
                }
            }

            Section("Yeni Açılanlar") {
                ForEach(openings) { place in
                    NavigationLink(value: place) {
                        PlaceRow(place: place)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

private struct TagsPageView: View {
    @EnvironmentObject private var store: PlaceStore

    private var categoryCounts: [(PlaceCategory, Int)] {
        PlaceCategory.allCases.map { category in
            (category, store.places.filter { $0.categories.contains(category) }.count)
        }
    }

    var body: some View {
        List {
            ForEach(categoryCounts, id: \.0) { category, count in
                HStack {
                    Text(category.rawValue)
                    Spacer()
                    Text("\(count)")
                        .foregroundColor(.secondary)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}
