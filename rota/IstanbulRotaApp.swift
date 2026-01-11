import SwiftUI

@main
struct IstanbulRotaApp: App {
    @StateObject private var store = PlaceStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
