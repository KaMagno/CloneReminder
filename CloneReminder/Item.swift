//
//  Item.swift
//  CloneReminder
//
//  Created by Kaique Magno on 22/04/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
