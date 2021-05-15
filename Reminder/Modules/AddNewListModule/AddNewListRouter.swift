import UIKit

protocol AddNewListPresenterToRouter {
    func dismiss()
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
        interactor.presenter = presenter
        return view
    }
}

extension AddNewListRouter: AddNewListPresenterToRouter {
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }
}

