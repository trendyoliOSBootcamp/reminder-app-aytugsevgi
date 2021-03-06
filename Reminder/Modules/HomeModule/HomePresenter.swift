import Foundation

protocol HomePresenterInterface {
    var numberOfRows: Int { get }
    var remindersCount: Int { get }
    var flaggedRemindersCount: Int { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func addListButtonTapped()
    func newReminderButtonTapped()
    func cellForItemAt(index: Int) -> ReminderList
    func didSelectRowAt(indexPath: IndexPath)
    func allViewTapped()
    func flaggedViewTapped()
    func updateSearchResults(text: String)
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
    var remindersCount: Int { reminders.count }
    var flaggedRemindersCount: Int { reminders.filter { $0.isFlag }.count }
    
    func viewDidLoad() {
        view?.configure()
        interactor.fetchLists()
    }
    
    func viewWillAppear() {
        view?.resetNavigationBar()
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
        router.push(identifier: .list, delegate: self, args: list)
    }
    
    func allViewTapped() {
        var allReminders = [Reminder]()
        listModels.forEach { allReminders.append(contentsOf: $0.reminders) }
        let reminderList = ReminderList(id: UUID(), name: "All", color: 12, image: "", reminders: allReminders)
        router.push(identifier: .list, delegate: self, args: reminderList)
    }
    
    func flaggedViewTapped() {
        var allReminders = [Reminder]()
        listModels.forEach { allReminders.append(contentsOf: $0.reminders )}
        let reminderList = ReminderList(id: UUID(), name: "Flagged", color: 1,
                                        image: "", reminders: allReminders.filter {??$0.isFlag })
        router.push(identifier: .list, delegate: self, args: reminderList)
    }
    
    func updateSearchResults(text: String) {
        var viewModels = [SearchControllerViewModel]()
        for listModel in listModels {
            let filteredReminders = listModel.reminders.filter { $0.content.lowercased()
                .contains(text.lowercased()) }
            guard !filteredReminders.isEmpty else { continue }
            let color = ListColor.init(rawValue: listModel.color)?.color ?? ListColor.darkGray.color
            let viewModel = SearchControllerViewModel(listTitle: listModel.name, listColor: color, reminders: filteredReminders)
            viewModels.append(viewModel)
        }
        view?.showSearchResult(viewModels: viewModels)
    }
}

extension HomePresenter: NewReminderListSavedDelegate {
    func newReminderListDidSaved(savedReminderList: ReminderList) {
        listModels.append(savedReminderList)
        view?.reloadData()
    }
}

extension HomePresenter: ReminderDelegate {
    func didAddNewReminder(reminder: Reminder) {
        var newReminderLists = [ReminderList]()
        reminders.append(reminder)
        for var reminderList in listModels {
            if reminderList.id == reminder.reminderListId {
                reminderList.reminders.append(reminder)
            }
            newReminderLists.append(reminderList)
        }
        listModels = newReminderLists
        view?.setAllReminderLabelText()
        view?.setFlaggedReminderLabelText()
        view?.reloadData()
    }
    
    func didDeleteReminder(reminder: Reminder) {
        var newReminderLists = [ReminderList]()
        reminders.removeAll(where: { $0.id == reminder.id })
        for var reminderList in listModels {
            if reminderList.id == reminder.reminderListId {
                reminderList.reminders.removeAll(where: { $0.id == reminder.id })
            }
            newReminderLists.append(reminderList)
        }
        listModels = newReminderLists
        view?.setAllReminderLabelText()
        view?.setFlaggedReminderLabelText()
        view?.reloadData()
    }
    
    func didChangeFlag(reminder: Reminder) {
        var newReminderLists = [ReminderList]()
        reminders.indices.filter { reminders[$0].id == reminder.id }
            .forEach { reminders[$0].isFlag = reminder.isFlag }
        for var reminderList in listModels {
            reminderList.reminders.indices.filter { reminderList.reminders[$0].id == reminder.id }
                .forEach { reminderList.reminders[$0].isFlag = reminder.isFlag }
            newReminderLists.append(reminderList)
        }
        listModels = newReminderLists
        view?.setAllReminderLabelText()
        view?.setFlaggedReminderLabelText()
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
        view?.setAllReminderLabelText()
        view?.setFlaggedReminderLabelText()
        view?.reloadData()
    }
}
