import UIKit

class AddNewListNavigatable: Navigatable {
    func isSatisfied(identifier: StoryboardId, delegate: AnyObject?, args: Any? = nil) -> Bool {
        identifier == .addNewList && delegate is NewReminderListSavedDelegate
    }
    
    func execute(navigationController: UINavigationController?, delegate: AnyObject?, args: Any? = nil) {
        guard let delegate = delegate as? NewReminderListSavedDelegate else { return }
        let view = AddNewListRouter.createModule(using: navigationController, delegate: delegate)
        navigationController?.present(view, animated: true)
    }
}
