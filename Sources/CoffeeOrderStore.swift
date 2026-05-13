import Observation

@MainActor
@Observable
final class CoffeeOrderStore {
    var customerName = "Freewind"
    var cups = 1
    var wantsOatMilk = false

    var summary: String {
        let milk = wantsOatMilk ? "Oat Milk" : "Regular Milk"
        return "\(customerName) / \(cups) cup / \(milk)"
    }

    func reset() {
        customerName = "Freewind"
        cups = 1
        wantsOatMilk = false
    }
}
