import Foundation

protocol HomeRouterToPresenter {
    
}

protocol HomeViewControllerToPresenter {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func updateSearchResults(text: String?)
    func viewDidLayoutSubviews()
}

protocol HomeInteractorToPresenter {
    
}

final class HomePresenter {
    private weak var view: HomePresenterToViewController?
    private let interactor: HomePresenterToInteractor
    private let router: HomePresenterToRouter
    
    init(view: HomePresenterToViewController, router: HomePresenterToRouter, interactor: HomePresenterToInteractor) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomeRouterToPresenter {
    
}

extension HomePresenter: HomeViewControllerToPresenter {
    var numberOfRows: Int { 5 }
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func updateSearchResults(text: String?) {
        guard let text = text else { return }
        view?.showSearchResult(text: text)
    }
    
    func viewDidLayoutSubviews() {
        view?.setTableViewHeight()
    }
}

extension HomePresenter: HomeInteractorToPresenter {
    
}
