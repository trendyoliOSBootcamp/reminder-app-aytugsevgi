import UIKit

final class HomeRouter {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
        
    static func createModule(using navigationController: UINavigationController) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor()
        let router = HomeRouter(navigationController: navigationController)
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.presenter = presenter
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
