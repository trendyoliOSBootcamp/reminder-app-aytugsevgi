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

extension PushableViewController {
    func execute(navigationController: UINavigationController?) {
        guard let viewController = viewController else { return }
        navigationController?.present(viewController, animated: true)
    }
}

class AddNewListPushable: PushableViewController {
    var viewController: UIViewController?
    
    func isSatisfied(identifier: StoryboardId) -> Bool {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(identifier: identifier.rawValue)
                as? AddNewListViewController else { return false }
        self.viewController = viewController
        return true
    }
}

class AddNewReminderPushable: PushableViewController {
    var viewController: UIViewController?
    
    func isSatisfied(identifier: StoryboardId) -> Bool {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(identifier: identifier.rawValue)
                as? AddNewReminderViewController else { return false }
        self.viewController = viewController
        return true
    }
}

class PushableViewControllerManager {
    static let shared = PushableViewControllerManager()
    private let items: [PushableViewController] = [AddNewListPushable(), AddNewReminderPushable()]
    
    func push(_ identifier: StoryboardId, with navigationController: UINavigationController?) {
        items.first(where: {$0.isSatisfied(identifier: identifier)})?.execute(navigationController: navigationController)
    }
}
