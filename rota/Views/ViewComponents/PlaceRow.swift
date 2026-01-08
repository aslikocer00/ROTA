import SwiftUI

struct PlaceRow: View {
    @EnvironmentObject private var store: PlaceStore
    let place: Place

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                PlaceImageView(name: place.coverImage, cornerRadius: 12)
                    .frame(width: 88, height: 88)
                if place.isFeatured {
                    Text("Öne çıkan")
                        .font(.caption2.weight(.semibold))
                        .padding(6)
                        .background(Color.accentColor.opacity(0.8))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .offset(x: 8, y: -8)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(place.name)
                        .font(.headline)
                    Spacer()
                    Button {
                        store.toggleFavorite(place)
                    } label: {
                        Image(systemName: store.isFavorite(place) ? "heart.fill" : "heart")
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.plain)
                }
                Text(place.headline)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                HStack(spacing: 8) {
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
                    if place.isBookable {
                        Text("Rezervasyon")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.accentColor.opacity(0.15))
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}
