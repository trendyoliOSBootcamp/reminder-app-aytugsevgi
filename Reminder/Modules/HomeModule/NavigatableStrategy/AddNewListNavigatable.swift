import UIKit

class AddNewListNavigatable: Navigatable {
    func isSatisfied(identifier: StoryboardId) -> Bool {
        identifier == .addNewList
    }
    
    func execute(navigationController: UINavigationController?) {
        let view = AddNewListRouter.createModule(using: navigationController)
        navigationController?.present(view, animated: true)
    }
}
