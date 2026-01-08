import SwiftUI

@main
struct IstanbulOneZoneApp: App {
    @StateObject private var store = PlaceStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
