import UIKit

final class AddNewReminderNavigatable: Navigatable {
    func isSatisfied(identifier: StoryboardId, delegate: AnyObject?, args: Any? = nil) -> Bool {
        identifier == .addNewReminder && delegate is ReminderDelegate
    }
    
    func execute(navigationController: UINavigationController?, delegate: AnyObject?, args: Any? = nil) {
        guard let delegate = delegate as? ReminderDelegate else { return }
        let view = AddNewReminderRouter.createModule(using: navigationController, delegate: delegate)
        navigationController?.present(view, animated: true)
    }
}
