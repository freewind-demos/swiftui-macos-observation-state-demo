import SwiftUI

struct ContentView: View {
    let store: CoffeeOrderStore

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            EditorPanel(store: store)
            PreviewPanel(store: store)
        }
        .padding(20)
        .frame(minWidth: 760, minHeight: 420, alignment: .topLeading)
    }
}

private struct EditorPanel: View {
    @Bindable var store: CoffeeOrderStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Edit State")
                .font(.title2.bold())

            Text("root view owns store. child view edits via @Bindable.")
                .foregroundStyle(.secondary)

            TextField("Customer", text: $store.customerName)
                .textFieldStyle(.roundedBorder)

            Stepper(value: $store.cups, in: 1...5) {
                Text("Cups: \(store.cups)")
            }

            Toggle("Use oat milk", isOn: $store.wantsOatMilk)

            Button("Reset") {
                store.reset()
            }

            Spacer(minLength: 0)
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 300, alignment: .topLeading)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct PreviewPanel: View {
    let store: CoffeeOrderStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Reactive Preview")
                .font(.title2.bold())

            Text("read-only child still auto refreshes when store changes.")
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 12) {
                row("Customer", store.customerName)
                row("Cups", "\(store.cups)")
                row("Milk", store.wantsOatMilk ? "Oat Milk" : "Regular Milk")
            }

            Divider()

            Text("Summary")
                .font(.headline)

            Text(store.summary)
                .font(.system(.title3, design: .monospaced))

            Spacer(minLength: 0)
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 300, alignment: .topLeading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func row(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
        }
    }
}
