import UIKit

class AddNewReminderNavigatable: Navigatable {
    func isSatisfied(identifier: StoryboardId, delegate: AnyObject?) -> Bool {
        identifier == .addNewReminder
    }
    
    func execute(navigationController: UINavigationController?, delegate: AnyObject?) {
        let view = AddNewReminderRouter.createModule(using: navigationController)
        navigationController?.present(view, animated: true)
    }
}
