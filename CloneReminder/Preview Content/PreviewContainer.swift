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
    .init(iconName: "cart", name: "Shopping Cart", color: .cyan, items: [
        .init(name: "Milk", isCompleted: false),
        .init(name: "Bread", isCompleted: true),
        .init(name: "Eggs", isCompleted: false),
        .init(name: "Butter", isCompleted: false),
        .init(name: "Cheese", isCompleted: false),
    ]),
    .init(iconName: "fork.knife", name: "Dinner Party", color: .orange, items: [
        .init(name: "Pasta", isCompleted: false),
        .init(name: "Tomato Sauce", isCompleted: true),
        .init(name: "Parmesan", isCompleted: false)
    ]),
    .init(iconName: "book", name: "Reading List", color: .purple, items: [
        .init(name: "Swift Concurrency", isCompleted: false),
        .init(name: "Design Patterns", isCompleted: false),
        .init(name: "Clean Code", isCompleted: true)
    ]),
    .init(iconName: "bag", name: "Work Tasks", color: .blue, items: [
        .init(name: "Reply to emails", isCompleted: true),
        .init(name: "Prepare slides", isCompleted: false),
        .init(name: "Standup notes", isCompleted: false)
    ]),
    .init(iconName: "house", name: "Home Chores", color: .green, items: [
        .init(name: "Vacuum living room", isCompleted: false),
        .init(name: "Laundry", isCompleted: true),
        .init(name: "Dishes", isCompleted: false)
    ]),
    .init(iconName: "airplane", name: "Trip Packing", color: .teal, items: [
        .init(name: "Passport", isCompleted: true),
        .init(name: "Charger", isCompleted: false),
        .init(name: "Toiletries", isCompleted: false)
    ]),
    .init(iconName: "gift", name: "Birthday Prep", color: .pink, items: [
        .init(name: "Buy gift", isCompleted: false),
        .init(name: "Wrap present", isCompleted: false),
        .init(name: "Write card", isCompleted: true)
    ]),
    .init(iconName: "cart.badge.plus", name: "Weekly Groceries", color: .mint, items: [
        .init(name: "Apples", isCompleted: false),
        .init(name: "Yogurt", isCompleted: true),
        .init(name: "Chicken", isCompleted: false)
    ]),
    .init(iconName: "wrench.and.screwdriver", name: "DIY Projects", color: .brown, items: [
        .init(name: "Fix shelf", isCompleted: false),
        .init(name: "Paint wall", isCompleted: false),
        .init(name: "Replace bulb", isCompleted: true)
    ]),
    .init(iconName: "heart", name: "Wellness", color: .red, items: [
        .init(name: "Meditate", isCompleted: true),
        .init(name: "Run 5k", isCompleted: false),
        .init(name: "Drink water", isCompleted: false)
    ])
]
