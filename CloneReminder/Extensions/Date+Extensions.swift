import Foundation

extension Date {
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    
    var dueDateDescription: String {
        if isToday { return "Today" }
        if isTomorrow { return "Tomorrow" }
        return DateFormatter.dateFormatted(from: self)
    }
    
    var dueHourDescription: String {
        DateFormatter.hourFormatted(from: self)
    }
}
