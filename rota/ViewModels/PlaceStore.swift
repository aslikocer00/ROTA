import Foundation
import CoreLocation

@MainActor
final class PlaceStore: ObservableObject {
    @Published private(set) var places: [Place] = MockData.places
    @Published private(set) var favorites: Set<UUID> = []

    func toggleFavorite(_ place: Place) {
        if favorites.contains(place.id) {
            favorites.remove(place.id)
        } else {
            favorites.insert(place.id)
        }
    }

    func isFavorite(_ place: Place) -> Bool {
        favorites.contains(place.id)
    }
}
