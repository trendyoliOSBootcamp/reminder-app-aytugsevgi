import Foundation

protocol HomePresenterInterface {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func updateSearchResults(text: String?)
    func viewDidLayoutSubviews()
    func addListButtonTapped()
    func newReminderButtonTapped()
}

protocol HomePresenterOutputInterface {
    func listFetched(listModels: [ListModel])
}

final class HomePresenter {
    private weak var view: HomeViewInterface?
    private let interactor: HomeInteractorInterface
    private let router: HomeRouterInterface
    private var listModels = [ListModel]()
    
    init(view: HomeViewInterface, router: HomeRouterInterface, interactor: HomeInteractorInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterInterface {
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

extension HomePresenter: HomePresenterOutputInterface {
    func listFetched(listModels: [ListModel]) {
        self.listModels = listModels
        view?.reloadData()
    }
}
