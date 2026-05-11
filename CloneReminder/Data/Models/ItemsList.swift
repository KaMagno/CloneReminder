import Foundation
import SwiftData
import SwiftUI

@Model
final class ItemsList {
    var uuid: UUID
    var iconName: String
    var name: String
    var colorHex: String
    
    @Relationship(deleteRule: .cascade)
    var items: [Item]
    
    init(uuid: UUID = .init(), iconName: String, name: String, colorHex: String = "F0F0F0", items: [Item] = []) {
        self.uuid = uuid
        self.iconName = iconName
        self.name = name
        self.colorHex = colorHex
        self.items = items
    }
}

extension ItemsList {
    static var mock: ItemsList {
        .init(
            iconName: "cart",
            name: "Groceries",
            colorHex: "AF7261",
            items: [
                Item(name: "Milk", notes: "Raw milk", reminderDate: .now, reminderTime: .now, isCompleted: true, list: nil),
                Item(name: "Eggs", notes: "Free-range", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Bread", notes: "Sourdough loaf", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Chicken", notes: "2 lbs thighs", reminderDate: .now, reminderTime: .now, isCompleted: false, list: nil),
                Item(name: "Apples", notes: "Honeycrisp", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Pasta", notes: "Spaghetti", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]
        )
    }
}

extension Array where Element == ItemsList {
    static var mocks: [ItemsList] {
        [
            ItemsList(iconName: "cart", name: "Groceries", colorHex: "#007AFF", items: [
                Item(name: "Milk", notes: "Raw milk", reminderDate: .now, reminderTime: .now, isCompleted: true, list: nil),
                Item(name: "Eggs", notes: "Free-range", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Bread", notes: "Sourdough loaf", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Chicken", notes: "2 lbs thighs", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Apples", notes: "Honeycrisp", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Pasta", notes: "Spaghetti", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),        // .blue (iOS link blue)
            ItemsList(iconName: "briefcase", name: "Work", colorHex: "#A2845E", items: [
                Item(name: "Reply to emails", notes: "Inbox zero", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Standup notes", notes: "Key blockers", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Plan sprint", notes: "Capacity & scope", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Code review PR #42", notes: "Check tests", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Update docs", notes: "API changes", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Sync with design", notes: "New components", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),        // .brown
            ItemsList(iconName: "airplane", name: "Travel", colorHex: "#00FFFF", items: [
                Item(name: "Book flights", notes: "Use miles", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Hotel options", notes: "Near center", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Packing list", notes: "Carry-on only", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Airport transfer", notes: "Shuttle vs taxi", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Travel insurance", notes: "Compare plans", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Itinerary printout", notes: "PDF backup", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),       // .cyan
            ItemsList(iconName: "figure.walk", name: "Fitness", colorHex: "#8E8E93", items: [
                Item(name: "Morning run", notes: "5km easy", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Stretching", notes: "10 min", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Strength training", notes: "Upper body", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Yoga session", notes: "Vinyasa flow", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Hydration", notes: "2L water", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Evening walk", notes: "20 min", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),   // .gray (system gray)
            ItemsList(iconName: "house", name: "Home Projects", colorHex: "#5856D6", items: [
                Item(name: "Paint living room", notes: "Matte finish", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Fix leaky faucet", notes: "Buy washer", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Organize garage", notes: "Label bins", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Garden cleanup", notes: "Trim hedges", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Replace bulbs", notes: "LED warm", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Clean gutters", notes: "Before rain", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),   // .indigo
            ItemsList(iconName: "book", name: "Reading", colorHex: "#AF52DE", items: [
                Item(name: "Finish chapter 5", notes: "Take notes", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Annotate key points", notes: "Use tags", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Start new novel", notes: "Sci-fi", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Library returns", notes: "Due Friday", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Book club notes", notes: "Meeting Tue", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Reading list update", notes: "Add recs", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),          // .purple
            ItemsList(iconName: "film", name: "Movies to Watch", colorHex: "#FF9500", items: [
                Item(name: "Inception", notes: "Nolan", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "The Martian", notes: "Ridley Scott", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Arrival", notes: "Villeneuve", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Interstellar", notes: "Nolan", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Blade Runner 2049", notes: "Villeneuve", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Dune", notes: "Villeneuve", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),  // .orange
            ItemsList(iconName: "gift", name: "Gift Ideas", colorHex: "#FFCC00", items: [
                Item(name: "Coffee grinder", notes: "Burr", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Cookbook", notes: "Italian", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Board game", notes: "Strategy", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Headphones", notes: "Noise-cancelling", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Smart mug", notes: "Temp control", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Scented candles", notes: "Lavender", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),       // .yellow
            ItemsList(iconName: "fork.knife", name: "Recipes", colorHex: "#00C7BE", items: [
                Item(name: "Carbonara", notes: "Guanciale", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Chicken curry", notes: "Mild", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Veggie stir-fry", notes: "Sesame oil", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Pancakes", notes: "Maple syrup", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Chili con carne", notes: "Kidney beans", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Tomato soup", notes: "Basil", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),    // .mint/teal-ish
            ItemsList(iconName: "graduationcap", name: "Learning", colorHex: "#FF3B30", items: [
                Item(name: "SwiftUI tutorial", notes: "Layouts", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Algorithms practice", notes: "Sorting", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Design patterns", notes: "MVVM", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Data structures", notes: "Trees", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Networking basics", notes: "URLSession", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil),
                Item(name: "Concurrency", notes: "async/await", reminderDate: nil, reminderTime: nil, isCompleted: false, list: nil)
            ]),// .red
        ]
    }
}
