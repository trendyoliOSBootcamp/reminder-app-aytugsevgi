import UIKit

enum StoryboardId: String {
    case addNewListViewController = "AddNewListViewController"
    case addNewReminderViewController = "AddNewReminderViewController"
}

protocol PushableViewController {
    var viewController: UIViewController? { get }
    func isSatisfied(identifier: StoryboardId) -> Bool
    func execute(navigationController: UINavigationController?)
}

class AddNewListPushable: PushableViewController {
    var viewController: UIViewController?
    
    func isSatisfied(identifier: StoryboardId) -> Bool {
        guard identifier == .addNewListViewController else { return false}
        return true
    }
    
    func execute(navigationController: UINavigationController?) {
        let view = AddNewListRouter.createModule(using: navigationController)
        navigationController?.present(view, animated: true)
    }
}

class AddNewReminderPushable: PushableViewController {
    var viewController: UIViewController?
    
    func isSatisfied(identifier: StoryboardId) -> Bool {
        guard identifier == .addNewReminderViewController else { return false}
        return true
    }
    
    func execute(navigationController: UINavigationController?) {
//        let view = AddNewReminderRouter.createModule(using: navigationController)
//        navigationController?.present(view, animated: true)
    }
}

class PushableViewControllerManager {
    static let shared = PushableViewControllerManager()
    private let items: [PushableViewController] = [AddNewListPushable(), AddNewReminderPushable()]
    
    func push(_ identifier: StoryboardId, with navigationController: UINavigationController?) {
        items.first(where: {$0.isSatisfied(identifier: identifier)})?.execute(navigationController: navigationController)
    }
}
