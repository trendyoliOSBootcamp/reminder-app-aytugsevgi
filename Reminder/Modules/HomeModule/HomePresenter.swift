import Foundation

protocol HomePresenterInterface {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func viewWillAppear()
    func updateSearchResults(text: String?)
    func addListButtonTapped()
    func newReminderButtonTapped()
    func cellForItemAt(index: Int) -> ReminderList
    func didSelectRowAt(indexPath: IndexPath)
    func allViewTapped()
    func flaggedViewTapped()
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
    
    func viewWillAppear() {
        view?.resetNavigationBar()
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
    
    func didSelectRowAt(indexPath: IndexPath) {
        guard let list = listModels[safe: indexPath.row] else { return }
        router.push(identifier: .list, args: list)
    }
    
    func allViewTapped() {
        var allReminders = [Reminder]()
        listModels.forEach { allReminders.append(contentsOf: $0.reminders) }
        let reminderList = ReminderList(id: UUID(), name: "All", color: 12, image: "", reminders: allReminders)
        router.push(identifier: .list, args: reminderList)
    }
    
    func flaggedViewTapped() {
        var allReminders = [Reminder]()
        listModels.forEach { allReminders.append(contentsOf: $0.reminders )}
        let reminderList = ReminderList(id: UUID(), name: "Flagged", color: 1,
                                        image: "", reminders: allReminders.filter { $0.isFlag })
        router.push(identifier: .list, args: reminderList)
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
