import UIKit

protocol AddNewReminderRouterInterface {
    func dismiss(completion: (() -> Void)?)
    func showAlert(title: String, message: String)
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
    func dismiss(completion: (() -> Void)? = nil) {
        navigationController?.dismiss(animated: true, completion: completion)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        navigationController?.present(alert, animated: true)
    }
}
