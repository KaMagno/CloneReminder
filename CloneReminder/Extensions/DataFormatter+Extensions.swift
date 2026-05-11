import Foundation

enum DateFormatter {
    static func dateFormatted(from date: Date) -> String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    static func hourFormatted(from date: Date) -> String {
        date.formatted(date: .omitted, time: .shortened)
    }
}
