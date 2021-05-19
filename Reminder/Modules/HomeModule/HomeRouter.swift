import UIKit

protocol HomeRouterInterface {
    func push(identifier: StoryboardId)
    func push(identifier: StoryboardId, delegate: AnyObject)
    func push(identifier: StoryboardId, args: Any)
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
    func push(identifier: StoryboardId, delegate: AnyObject) {
        NavigatableManager.shared.push(to: identifier, navigationController: navigationController, delegate: delegate)
    }
    
    func push(identifier: StoryboardId) {
        NavigatableManager.shared.push(to: identifier, navigationController: navigationController)
    }
    
    func push(identifier: StoryboardId, args: Any) {
        NavigatableManager.shared.push(to: identifier, navigationController: navigationController, args: args)
    }
}
