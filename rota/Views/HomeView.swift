import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: PlaceStore

    private var featured: [Place] {
        store.places.filter { $0.isFeatured }
    }

    private var openings: [Place] {
        store.places.filter { !$0.isFeatured }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                section(title: "Trend İstanbul", actionTitle: "Tümünü Gör", places: featured)
                section(title: "Yeni Açılanlar", actionTitle: "Tümünü Gör", places: openings)
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .navigationTitle("onezone")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Place.self) { place in
            PlaceDetailView(place: place)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("onezone onaylı mekanlar")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("İstanbul'un en iyi restoranları, kafeleri ve barları")
                .font(.title2.weight(.semibold))
        }
        .padding(.top, 16)
    }

    private func section(title: String, actionTitle: String, places: [Place]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text(actionTitle)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.accentColor)
            }

            LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 12) {
                ForEach(places) { place in
                    NavigationLink(value: place) {
                        HomeCard(place: place)
                    }
                }
            }
        }
    }
}

private struct HomeCard: View {
    @EnvironmentObject private var store: PlaceStore
    let place: Place

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                PlaceImageView(name: place.coverImage, cornerRadius: 12)
                    .frame(height: 180)

                Button {
                    store.toggleFavorite(place)
                } label: {
                    Image(systemName: store.isFavorite(place) ? "heart.fill" : "heart")
                        .padding(8)
                        .background(.thinMaterial, in: Circle())
                        .foregroundColor(.accentColor)
                }
                .padding(8)
            }

            Text(place.name)
                .font(.headline)
            Text(place.headline)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)

            HStack(spacing: 6) {
                Text(place.area.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.secondary.opacity(0.12))
                    .clipShape(Capsule())
                Text(place.price.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.secondary.opacity(0.12))
                    .clipShape(Capsule())
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.secondary.opacity(0.15))
                .background(RoundedRectangle(cornerRadius: 14).fill(Color(.secondarySystemBackground)))
        )
    }
}
