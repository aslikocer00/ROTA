import SwiftUI

struct MapTabView: View {
    @EnvironmentObject private var store: PlaceStore

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.accentColor)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Harita")
                        .font(.headline)
                    Text("\(store.places.count) mekan")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()

            IstanbulMapView(places: store.places)
                .overlay(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground).opacity(0.9))
                        .frame(height: 24)
                }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
