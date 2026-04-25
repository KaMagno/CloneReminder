import Foundation
import SwiftData

@Model
final class Item {
    var uuid: UUID
    var name: String
    var isCompleted: Bool
    
    init(uuid: UUID = .init(), name: String, isCompleted: Bool) {
        self.uuid = uuid
        self.name = name
        self.isCompleted = isCompleted
    }
}
