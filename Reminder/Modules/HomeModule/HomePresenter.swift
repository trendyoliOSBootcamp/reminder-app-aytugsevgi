import Foundation

protocol HomePresenterInterface {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func updateSearchResults(text: String?)
    func viewDidLayoutSubviews()
    func addListButtonTapped()
    func newReminderButtonTapped()
    func cellForItemAt(index: Int) -> ReminderList
}

protocol HomePresenterOutputInterface: AnyObject {
    func listFetched(listModels: [ReminderList])
}

final class HomePresenter {
    private weak var view: HomeViewInterface?
    private let interactor: HomeInteractorInterface
    private let router: HomeRouterInterface
    private var listModels = [ReminderList]()
    
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
        // filtered reminders
        view?.showSearchResult(reminders: [])
    }
    
    func cellForItemAt(index: Int) -> ReminderList {
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
    func listFetched(listModels: [ReminderList]) {
        self.listModels = listModels
        view?.reloadData()
        print(listModels.count)
    }
}
