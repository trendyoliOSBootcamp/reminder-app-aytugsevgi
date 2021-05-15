import UIKit

protocol AddNewListRouterInterface{
    func dismiss()
    func showAlert(title: String, message: String)
}

final class AddNewListRouter {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController?) -> UIViewController {
        let view = UIStoryboard.instantiateViewController(type: AddNewListViewController.self)
        let interactor = AddNewListInteractor()
        let router = AddNewListRouter(navigationController: navigationController)
        let presenter = AddNewListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension AddNewListRouter: AddNewListRouterInterface {
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .cancel)
        alert.addAction(action)
        navigationController?.present(alert, animated: true)
    }
}

