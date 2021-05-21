import UIKit

protocol ListRouterInterface {
    func push(identifier: StoryboardId, delegate: AnyObject)
}

final class ListRouter {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController?, reminderList: ReminderList, delegate: ReminderDelegate?) -> UIViewController {
        let view = UIStoryboard.instantiateViewController(type: ListViewController.self)
        let interactor = ListInteractor()
        let router = ListRouter(navigationController: navigationController)
        let presenter = ListPresenter(view: view, interactor: interactor, router: router, reminderList: reminderList, delegate: delegate)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension ListRouter: ListRouterInterface {
    func push(identifier: StoryboardId, delegate: AnyObject) {
        NavigatableManager.shared.push(to: identifier, navigationController: navigationController, delegate: delegate)
    }
}
