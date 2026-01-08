import SwiftUI
import MapKit

struct IstanbulMapView: View {
    let places: [Place]
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.0275, longitude: 28.9744),
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.1)
        )
    )
    @State private var selected: Place?

    var body: some View {
        Map(position: $cameraPosition, selection: $selected) {
            ForEach(places) { place in
                Annotation(place.name, coordinate: place.coordinate) {
                    ZStack {
                        Circle()
                            .fill(selected == place ? Color.accentColor : Color.accentColor.opacity(0.8))
                            .frame(width: selected == place ? 18 : 12, height: selected == place ? 18 : 12)
                        if selected == place {
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                                .font(.caption2)
                        }
                    }
                }
                .tag(place)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
