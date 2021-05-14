import UIKit

protocol AddNewListPresenterToRouter {
    func dismiss()
}

final class AddNewListRouter {
    private var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController?) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddNewListViewController") as! AddNewListViewController
        let interactor = AddNewListInteractor()
        let router = AddNewListRouter()
        let presenter = AddNewListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.navigationController = navigationController
        return view
    }
}

extension AddNewListRouter: AddNewListPresenterToRouter {
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }
}
