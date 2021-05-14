import UIKit

final class HomeRouter {
    private var navigationController: UINavigationController?
        
    static func createModule(using navigationController: UINavigationController) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.presenter = presenter
        router.navigationController = navigationController
        return view
    }
}

extension HomeRouter: HomePresenterToRouter {
    func showAlert() {
        
    }
    
    func push(identifier: StoryboardId) {
        ViewControllerNavigatableManager.shared.push(identifier,
                                                     with: navigationController)
    }
}
