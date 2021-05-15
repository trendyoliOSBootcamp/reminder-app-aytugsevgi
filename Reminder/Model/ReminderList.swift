import Foundation

struct ReminderList {
    var id: UUID
    var name: String
    var color: Int
    var image: String
    var reminders: [Reminder]
}

struct Reminder {
    var id: UUID
    var reminderListId: UUID
    var title: String
    var content: String
    var isFlag: Bool
    var priority: Priority
}

enum Priority: Int {
    case none = 0
    case normal
    case low
    case medium
    case high
}
