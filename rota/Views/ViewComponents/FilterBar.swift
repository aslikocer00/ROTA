import SwiftUI

struct FilterBar: View {
    let categories: [PlaceCategory]
    @Binding var selectedCategory: PlaceCategory?
    let priceLevels: [PriceLevel]
    @Binding var selectedPrice: PriceLevel?
    let areas: [Area]
    @Binding var selectedArea: Area?
    @Binding var showFavoritesOnly: Bool

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ToggleChip(title: "Favoriler", isOn: $showFavoritesOnly)
                PickerChip(
                    title: selectedCategory?.rawValue ?? "Kategori",
                    items: categories.map { $0.rawValue }
                ) { index in
                    selectedCategory = index == nil ? nil : categories[index!]
                }
                PickerChip(
                    title: selectedPrice?.rawValue ?? "Fiyat",
                    items: priceLevels.map { $0.rawValue }
                ) { index in
                    selectedPrice = index == nil ? nil : priceLevels[index!]
                }
                PickerChip(
                    title: selectedArea?.rawValue ?? "Semt",
                    items: areas.map { $0.rawValue }
                ) { index in
                    selectedArea = index == nil ? nil : areas[index!]
                }
            }
        }
    }
}

private struct ToggleChip: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Button {
            withAnimation { isOn.toggle() }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: isOn ? "heart.fill" : "heart")
                Text(title)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isOn ? Color.accentColor.opacity(0.2) : Color.secondary.opacity(0.12))
            )
        }
        .buttonStyle(.plain)
    }
}

private struct PickerChip: View {
    let title: String
    let items: [String]
    let onSelect: (Int?) -> Void
    @State private var isPresenting = false

    var body: some View {
        Menu {
            Button("Temizle") { onSelect(nil) }
            ForEach(Array(items.enumerated()), id: \.offset) { index, name in
                Button(name) { onSelect(index) }
            }
        } label: {
            HStack(spacing: 6) {
                Text(title)
                Image(systemName: "chevron.down")
                    .font(.footnote)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.secondary.opacity(0.12))
            )
        }
    }
}
