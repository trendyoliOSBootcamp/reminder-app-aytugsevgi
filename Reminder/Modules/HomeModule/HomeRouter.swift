import UIKit

protocol HomePresenterToRouter {
    func showAlert()
    func push()
}

final class HomeRouter {
    private var navigationController: UINavigationController?
        
    static func createModule(using navigationFactory: NavigationFactory) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.presenter = presenter
        router.navigationController = navigationFactory(view)
        return navigationFactory(view)
    }
}

extension HomeRouter: HomePresenterToRouter {
    func showAlert() {
        
    }
    
    func push() {
        
    }
    
    
}
