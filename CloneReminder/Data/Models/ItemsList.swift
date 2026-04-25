import Foundation
import SwiftData
import SwiftUI

@Model
final class ItemsList {
    var uuid: UUID
    var iconName: String
    var name: String
    
    @Transient
    var color: Color = .black
    
    @Relationship(deleteRule: .cascade)
    var items: [Item]
    
    init(uuid: UUID = .init(), iconName: String, name: String, color: Color, items: [Item] = []) {
        self.uuid = uuid
        self.iconName = iconName
        self.name = name
        self.color = color
        self.items = items
    }
}

extension ItemsList {
    static var mock: ItemsList {
        .init(iconName: "cart", name: "Groceries", color: .green)
    }
}

extension Array where Element == ItemsList {
    static var mocks: [ItemsList] {
        [
            ItemsList(iconName: "cart", name: "Groceries", color: .blue, items: []),
            ItemsList(iconName: "briefcase", name: "Work", color: .brown, items: []),
            ItemsList(iconName: "airplane", name: "Travel", color: .cyan, items: []),
            ItemsList(iconName: "figure.walk", name: "Fitness", color: .gray, items: []),
            ItemsList(iconName: "house", name: "Home Projects", color: .indigo, items: []),
            ItemsList(iconName: "book", name: "Reading", color: .purple, items: []),
            ItemsList(iconName: "film", name: "Movies to Watch", color: .orange, items: []),
            ItemsList(iconName: "gift", name: "Gift Ideas", color: .yellow, items: []),
            ItemsList(iconName: "fork.knife", name: "Recipes", color: .mint, items: []),
            ItemsList(iconName: "graduationcap", name: "Learning", color: .red, items: []),
        ]
    }
}
