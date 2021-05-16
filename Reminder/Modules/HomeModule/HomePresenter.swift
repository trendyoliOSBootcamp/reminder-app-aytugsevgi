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
    func remindersFetched(reminders: [Reminder])
}

final class HomePresenter {
    private weak var view: HomeViewInterface?
    private let interactor: HomeInteractorInterface
    private let router: HomeRouterInterface
    private var listModels = [ReminderList]()
    private var reminders = [Reminder]()
    
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
        router.push(identifier: .addNewReminder, delegate: self)
    }
}

extension HomePresenter: NewReminderListSavedDelegate {
    func newReminderListDidSaved(savedReminderList: ReminderList) {
        listModels.append(savedReminderList)
        view?.reloadData()
    }
}

extension HomePresenter: NewReminderSavedDelegate {
    func didReminderSave(reminder: Reminder) {
        var newReminderLists = [ReminderList]()
        for var reminderList in listModels {
            if reminderList.id == reminder.reminderListId {
                reminderList.reminders.append(reminder)
            }
            newReminderLists.append(reminderList)
        }
        listModels = newReminderLists
        view?.reloadData()
    }
}

extension HomePresenter: HomePresenterOutputInterface {
    func listFetched(listModels: [ReminderList]) {
        self.listModels = listModels
        interactor.fetchReminders()
    }
    
    func remindersFetched(reminders: [Reminder]) {
        self.reminders = reminders
        var newReminderLists = [ReminderList]()
        for var reminderList in listModels {
            reminderList.reminders.append(contentsOf: reminders.filter { $0.reminderListId.uuidString == reminderList.id.uuidString })
            newReminderLists.append(reminderList)
        }
        listModels = newReminderLists
        view?.reloadData()
    }
}
