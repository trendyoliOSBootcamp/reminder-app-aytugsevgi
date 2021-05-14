import UIKit

enum StoryboardId: String {
    case addNewListViewController = "AddNewListViewController"
    case addNewReminderViewController = "AddNewReminderViewController"
}

protocol ViewControllerNavigatable {
    
    func isSatisfied(identifier: StoryboardId) -> Bool
    func execute(navigationController: UINavigationController?)
}

class AddNewListNavigatable: ViewControllerNavigatable {
    
    func isSatisfied(identifier: StoryboardId) -> Bool {
        guard identifier == .addNewListViewController else { return false}
        return true
    }
    
    func execute(navigationController: UINavigationController?) {
        let view = AddNewListRouter.createModule(using: navigationController)
        navigationController?.present(view, animated: true)
    }
}

class AddNewReminderNavigatable: ViewControllerNavigatable {
    
    func isSatisfied(identifier: StoryboardId) -> Bool {
        guard identifier == .addNewReminderViewController else { return false}
        return true
    }
    
    func execute(navigationController: UINavigationController?) {
//        let view = AddNewReminderRouter.createModule(using: navigationController)
//        navigationController?.present(view, animated: true)
    }
}

class ViewControllerNavigatableManager {
    static let shared = ViewControllerNavigatableManager()
    private let items: [ViewControllerNavigatable] = [AddNewListNavigatable(), AddNewReminderNavigatable()]
    
    func push(_ identifier: StoryboardId, with navigationController: UINavigationController?) {
        items.first(where: {$0.isSatisfied(identifier: identifier)})?.execute(navigationController: navigationController)
    }
}
