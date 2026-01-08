import Foundation
import CoreLocation

struct Place: Identifiable, Hashable {
    let id: UUID
    let name: String
    let categories: [PlaceCategory]
    let price: PriceLevel
    let area: Area
    let headline: String
    let description: String
    let address: String
    let phone: String
    let website: URL?
    let instagram: URL?
    let images: [String]
    let coordinate: CLLocationCoordinate2D
    let isFeatured: Bool
    let isBookable: Bool
    let tags: [String]
    let hours: String

    init(
        id: UUID = UUID(),
        name: String,
        categories: [PlaceCategory],
        price: PriceLevel,
        area: Area,
        headline: String,
        description: String,
        address: String,
        phone: String,
        website: URL?,
        instagram: URL? = nil,
        images: [String],
        coordinate: CLLocationCoordinate2D,
        isFeatured: Bool = false,
        isBookable: Bool = false,
        tags: [String] = [],
        hours: String = "Her gün 12:00 - 23:00"
    ) {
        self.id = id
        self.name = name
        self.categories = categories
        self.price = price
        self.area = area
        self.headline = headline
        self.description = description
        self.address = address
        self.phone = phone
        self.website = website
        self.instagram = instagram
        self.images = images
        self.coordinate = coordinate
        self.isFeatured = isFeatured
        self.isBookable = isBookable
        self.tags = tags
        self.hours = hours
    }

    func matches(query: String) -> Bool {
        let q = query.lowercased()
        return name.lowercased().contains(q)
        || headline.lowercased().contains(q)
        || description.lowercased().contains(q)
        || area.rawValue.lowercased().contains(q)
        || categories.map { $0.rawValue.lowercased() }.contains(where: { $0.contains(q) })
    }

    var coverImage: String { images.first ?? "" }

    var phoneURL: URL? {
        let digits = phone.filter { $0.isNumber || $0 == "+" }
        return URL(string: "tel://\(digits)")
    }

    static func == (lhs: Place, rhs: Place) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
