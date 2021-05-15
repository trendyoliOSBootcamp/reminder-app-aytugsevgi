import UIKit

class AddNewReminderNavigatable: Navigatable {
    func isSatisfied(identifier: StoryboardId) -> Bool {
        identifier == .addNewReminder
    }
    
    func execute(navigationController: UINavigationController?) {
//        let view = AddNewReminderRouter.createModule(using: navigationController)
//        navigationController?.present(view, animated: true)
    }
}
