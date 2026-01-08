import SwiftUI
import MapKit

struct PlaceDetailView: View {
    @EnvironmentObject private var store: PlaceStore
    let place: Place

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TabView {
                    ForEach(place.images.indices, id: \.self) { idx in
                        PlaceImageView(name: place.images[idx], cornerRadius: 16, aspectRatio: 1.0)
                            .padding(.horizontal, 12)
                    }
                }
                .frame(height: 320)
                .tabViewStyle(.page(indexDisplayMode: .automatic))

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(place.name)
                            .font(.largeTitle.weight(.semibold))
                        Text(place.headline)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        HStack(spacing: 8) {
                            ForEach(place.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.secondary.opacity(0.12))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    Spacer()
                    Button {
                        store.toggleFavorite(place)
                    } label: {
                        Image(systemName: store.isFavorite(place) ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.plain)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Bilgi")
                        .font(.headline)
                    Text(place.description)
                    HStack {
                    Label(place.area.rawValue, systemImage: "mappin.and.ellipse")
                    Spacer()
                    Label(place.price.rawValue, systemImage: "coloncurrencysign.circle")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                contactLinks
                Label(place.address, systemImage: "location")
                    .font(.subheadline)
                Label(place.hours, systemImage: "clock")
                    .font(.subheadline)
            }

                Map(initialPosition: .region(MKCoordinateRegion(center: place.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))) {
                    Marker(place.name, coordinate: place.coordinate)
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private var contactLinks: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let phoneURL = place.phoneURL {
                Link(destination: phoneURL) {
                    Label(place.phone, systemImage: "phone")
                        .font(.subheadline)
                }
            } else {
                Label(place.phone, systemImage: "phone")
                    .font(.subheadline)
            }

            if let website = place.website {
                Link(destination: website) {
                    Label("Web Sitesi", systemImage: "safari")
                        .font(.subheadline)
                }
            }

            if let insta = place.instagram {
                Link(destination: insta) {
                    Label("Instagram", systemImage: "camera")
                        .font(.subheadline)
                }
            }
        }
    }
}
