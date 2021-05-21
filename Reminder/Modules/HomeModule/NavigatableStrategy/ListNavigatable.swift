import UIKit

final class ListNavigatable: Navigatable {
    func isSatisfied(identifier: StoryboardId, delegate: AnyObject?, args: Any? = nil) -> Bool {
        identifier == .list && args is ReminderList && delegate is ReminderDelegate
    }
    
    func execute(navigationController: UINavigationController?, delegate: AnyObject?, args: Any? = nil) {
        guard let args = args as? ReminderList else { return }
        guard let delegate = delegate as? ReminderDelegate else { return }
        let view = ListRouter.createModule(using: navigationController, reminderList: args, delegate: delegate)
        navigationController?.pushViewController(view, animated: true)
    }
}
