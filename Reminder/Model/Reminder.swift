import Foundation

struct Reminder {
    var id: UUID
    var reminderListId: UUID
    var title: String
    var content: String
    var isFlag: Bool
    var priority: Priority
}
