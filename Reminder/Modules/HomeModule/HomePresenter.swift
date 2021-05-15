import Foundation

protocol HomePresenterInterface {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func updateSearchResults(text: String?)
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
    
    func updateSearchResults(text: String?) {
        guard text != nil else { return }
        // filtered reminders
        view?.showSearchResult(reminders: [])
    }
    
    func cellForItemAt(index: Int) -> ReminderList {
        return listModels[index]
    }
    
    func addListButtonTapped() {
        router.push(identifier: .addNewList, delegate: self)
    }
    
    func newReminderButtonTapped() {
        router.push(identifier: .addNewReminder)
    }
}

extension HomePresenter: NewReminderListSavedDelegate {
    func newReminderListDidSaved(savedReminderList: ReminderList) {
        listModels.append(savedReminderList)
        view?.reloadData()
    }
}

extension HomePresenter: HomePresenterOutputInterface {
    func listFetched(listModels: [ReminderList]) {
        self.listModels = listModels
        view?.reloadData()
        print(listModels.count)
    }
}
