import Foundation

final class HomePresenter {
    private weak var view: HomePresenterToViewController?
    private let interactor: HomePresenterToInteractor
    private let router: HomePresenterToRouter
    private var listModels = [ListModel]()
    
    init(view: HomePresenterToViewController, router: HomePresenterToRouter, interactor: HomePresenterToInteractor) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomeRouterToPresenter {
    
}

extension HomePresenter: HomeViewControllerToPresenter {
    var numberOfRows: Int { listModels.count }
    
    func viewDidLoad() {
        view?.configure()
        interactor.fetchLists()
    }
    
    func viewDidLayoutSubviews() {
        view?.setTableViewHeight()
    }
    
    func updateSearchResults(text: String?) {
        guard let text = text else { return }
        view?.showSearchResult(text: text)
    }
    
    func cellForItemAt(index: Int) -> ListModel {
        return listModels[index]
    }
    
    func addListButtonTapped() {
        router.push(identifier: .addNewList)
    }
    
    func newReminderButtonTapped() {
        router.push(identifier: .addNewReminder)
    }
}

extension HomePresenter: HomeInteractorToPresenter {
    func listFetched(listModels: [ListModel]) {
        self.listModels = listModels
        view?.reloadData()
    }
}
