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
            colorHex: "AF7261"
        )
    }
}

extension Array where Element == ItemsList {
    static var mocks: [ItemsList] {
        [
            ItemsList(iconName: "cart", name: "Groceries", colorHex: "#007AFF", items: []),        // .blue (iOS link blue)
            ItemsList(iconName: "briefcase", name: "Work", colorHex: "#A2845E", items: []),        // .brown
            ItemsList(iconName: "airplane", name: "Travel", colorHex: "#00FFFF", items: []),       // .cyan
            ItemsList(iconName: "figure.walk", name: "Fitness", colorHex: "#8E8E93", items: []),   // .gray (system gray)
            ItemsList(iconName: "house", name: "Home Projects", colorHex: "#5856D6", items: []),   // .indigo
            ItemsList(iconName: "book", name: "Reading", colorHex: "#AF52DE", items: []),          // .purple
            ItemsList(iconName: "film", name: "Movies to Watch", colorHex: "#FF9500", items: []),  // .orange
            ItemsList(iconName: "gift", name: "Gift Ideas", colorHex: "#FFCC00", items: []),       // .yellow
            ItemsList(iconName: "fork.knife", name: "Recipes", colorHex: "#00C7BE", items: []),    // .mint/teal-ish
            ItemsList(iconName: "graduationcap", name: "Learning", colorHex: "#FF3B30", items: []),// .red
        ]
    }
}
