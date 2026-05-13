import SwiftUI

@main
struct SwiftUIObservationStateDemoApp: App {
    @State private var store = CoffeeOrderStore()

    var body: some Scene {
        Window("Observation State Demo", id: "main") {
            ContentView(store: store)
        }
        .defaultSize(width: 760, height: 420)
    }
}
