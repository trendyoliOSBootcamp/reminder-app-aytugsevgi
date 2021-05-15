import UIKit

class AddNewListNavigatable: Navigatable {
    func isSatisfied(identifier: StoryboardId, delegate: AnyObject?) -> Bool {
        identifier == .addNewList && delegate is NewReminderListSavedDelegate
    }
    
    func execute(navigationController: UINavigationController?, delegate: AnyObject?) {
        guard let delegate = delegate as? NewReminderListSavedDelegate else { return }
        let view = AddNewListRouter.createModule(using: navigationController, delegate: delegate)
        navigationController?.present(view, animated: true)
    }
}
