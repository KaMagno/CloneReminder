import SwiftData
import SwiftUI

@MainActor
var previewContainer: ModelContainer = {
    let container = try! ModelContainer(for:
        Item.self,
        ItemsList.self
    , configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    //Add sample data
    sampleDataItemsList.forEach { itemList in
        container.mainContext.insert(itemList)
    }
    
    return container
}()

fileprivate var sampleDataItemsList: [ItemsList] = [
    .init(iconName: "cart", name: "Shopping Cart", colorHex: "#007AFF", items: [
        .init(name: "Milk", isCompleted: false),
        .init(name: "Bread", isCompleted: true),
        .init(name: "Eggs", isCompleted: false),
        .init(name: "Butter", isCompleted: false),
        .init(name: "Cheese", isCompleted: false),
    ]),
    .init(iconName: "fork.knife", name: "Dinner Party", colorHex: "#A2845E", items: [
        .init(name: "Pasta", isCompleted: false),
        .init(name: "Tomato Sauce", isCompleted: true),
        .init(name: "Parmesan", isCompleted: false)
    ]),
    .init(iconName: "book", name: "Reading List", colorHex: "#00FFFF", items: [
        .init(name: "Swift Concurrency", isCompleted: false),
        .init(name: "Design Patterns", isCompleted: false),
        .init(name: "Clean Code", isCompleted: true)
    ]),
    .init(iconName: "bag", name: "Work Tasks", colorHex: "#8E8E93", items: [
        .init(name: "Reply to emails", isCompleted: true),
        .init(name: "Prepare slides", isCompleted: false),
        .init(name: "Standup notes", isCompleted: false)
    ]),
    .init(iconName: "house", name: "Home Chores", colorHex: "#5856D6", items: [
        .init(name: "Vacuum living room", isCompleted: false),
        .init(name: "Laundry", isCompleted: true),
        .init(name: "Dishes", isCompleted: false)
    ]),
    .init(iconName: "airplane", name: "Trip Packing", colorHex: "#AF52DE", items: [
        .init(name: "Passport", isCompleted: true),
        .init(name: "Charger", isCompleted: false),
        .init(name: "Toiletries", isCompleted: false)
    ]),
    .init(iconName: "gift", name: "Birthday Prep", colorHex: "#FF9500", items: [
        .init(name: "Buy gift", isCompleted: false),
        .init(name: "Wrap present", isCompleted: false),
        .init(name: "Write card", isCompleted: true)
    ]),
    .init(iconName: "cart.badge.plus", name: "Weekly Groceries", colorHex: "#FFCC00", items: [
        .init(name: "Apples", isCompleted: false),
        .init(name: "Yogurt", isCompleted: true),
        .init(name: "Chicken", isCompleted: false)
    ]),
    .init(iconName: "wrench.and.screwdriver", name: "DIY Projects", colorHex: "#00C7BE", items: [
        .init(name: "Fix shelf", isCompleted: false),
        .init(name: "Paint wall", isCompleted: false),
        .init(name: "Replace bulb", isCompleted: true)
    ]),
    .init(iconName: "heart", name: "Wellness", colorHex: "#FF3B30", items: [
        .init(name: "Meditate", isCompleted: true),
        .init(name: "Run 5k", isCompleted: false),
        .init(name: "Drink water", isCompleted: false)
    ])
]
