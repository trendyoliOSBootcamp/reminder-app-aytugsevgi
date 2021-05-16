import UIKit

class AddNewReminderNavigatable: Navigatable {
    func isSatisfied(identifier: StoryboardId, delegate: AnyObject?) -> Bool {
        identifier == .addNewReminder && delegate is NewReminderSavedDelegate
    }
    
    func execute(navigationController: UINavigationController?, delegate: AnyObject?) {
        guard let delegate = delegate as? NewReminderSavedDelegate else { return }
        let view = AddNewReminderRouter.createModule(using: navigationController, delegate: delegate)
        navigationController?.present(view, animated: true)
    }
}
