import UIKit

protocol ListRouterInterface {
    
}

final class ListRouter {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController?, reminderList: ReminderList) -> UIViewController {
        let view = UIStoryboard.instantiateViewController(type: ListViewController.self)
        let interactor = ListInteractor()
        let router = ListRouter(navigationController: navigationController)
        let presenter = ListPresenter(view: view, interactor: interactor, router: router, reminderList: reminderList)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension ListRouter: ListRouterInterface {
    
}
