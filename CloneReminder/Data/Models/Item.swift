import Foundation
import SwiftData

@Model
final class Item {
    var uuid: UUID
    var name: String
    var notes: String?
    var reminderDate: Date?
    var reminderTime: Date?
    var isCompleted: Bool
    
    var list: ItemsList?
    
    init(
        uuid: UUID = .init(),
        name: String,
        notes: String? = nil,
        reminderDate: Date? = nil,
        reminderTime: Date? = nil,
        isCompleted: Bool,
        list: ItemsList? = nil
    ) {
        self.uuid = uuid
        self.name = name
        self.notes = notes
        self.reminderDate = reminderDate
        self.reminderTime = reminderTime
        self.isCompleted = isCompleted
        self.list = list
    }
}
