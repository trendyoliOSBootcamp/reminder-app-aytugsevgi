import UIKit

protocol HomeRouterInterface {
    func showAlert()
    func push(identifier: StoryboardId)
}


final class HomeRouter {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
        
    static func createModule(using navigationController: UINavigationController) -> UIViewController {
        let view = UIStoryboard.instantiateViewController(type: HomeViewController.self)
        let interactor = HomeInteractor()
        let router = HomeRouter(navigationController: navigationController)
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension HomeRouter: HomeRouterInterface {
    func showAlert() {
        
    }
    
    func push(identifier: StoryboardId) {
        NavigatableManager.shared.push(to: identifier,
                                                     using: navigationController)
    }
}
