import UIKit

protocol AddNewReminderRouterInterface {
    
}

final class AddNewReminderRouter {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
        
    static func createModule(using navigationController: UINavigationController?) -> UIViewController {
        let view = UIStoryboard.instantiateViewController(type: AddNewReminderViewController.self)
        let interactor = AddNewReminderInteractor()
        let router = AddNewReminderRouter(navigationController: navigationController)
        let presenter = AddNewReminderPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }

}

extension AddNewReminderRouter: AddNewReminderRouterInterface {
    
}
