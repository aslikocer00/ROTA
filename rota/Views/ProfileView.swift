import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var store: PlaceStore
    @State private var searchText: String = ""

    private var favorites: [Place] {
        store.places.filter { store.isFavorite($0) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header

            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Favorilerde ara", text: $searchText)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
            .padding(.horizontal)

            List {
                Section("Favoriler") {
                    ForEach(filteredFavorites) { place in
                        NavigationLink(value: place) {
                            PlaceRow(place: place)
                        }
                    }
                    if filteredFavorites.isEmpty {
                        Text("Henüz favori eklenmedi.")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationDestination(for: Place.self) { place in
            PlaceDetailView(place: place)
        }
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var filteredFavorites: [Place] {
        favorites.filter { searchText.isEmpty ? true : $0.matches(query: searchText) }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(Color.accentColor.opacity(0.15))
                    .frame(width: 48, height: 48)
                    .overlay(Image(systemName: "person.fill").foregroundColor(.accentColor))

                VStack(alignment: .leading, spacing: 4) {
                    Text("Rota Foodie")
                        .font(.headline)
                    Text("İstanbul")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                Spacer()
                Button("Ayarlar") {}
                    .font(.subheadline.weight(.semibold))
            }
            .padding(.horizontal)

            HStack(spacing: 24) {
                statView(value: "12", label: "Been")
                statView(value: "\(favorites.count)", label: "Favorites")
                statView(value: "6", label: "Go Try")
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
        }
        .padding(.top, 12)
    }

    private func statView(value: String, label: String) -> some View {
        VStack {
            Text(value).font(.headline)
            Text(label).foregroundColor(.secondary).font(.caption)
        }
    }
}
