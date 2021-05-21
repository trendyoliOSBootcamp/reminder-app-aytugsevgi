import Foundation

protocol ListPresenterInterface {
    var numberOfRows: Int { get }
    
    func viewDidLoad()
    func cellForRowItemAt(_ row: Int) -> Reminder?
    func newReminderButtonTapped()
    func deleteActionTapped(at indexPath: IndexPath)
}

protocol ListPresenterOutputInterface: AnyObject {
    func reminderDeleteFailed()
    func reminderDeleted(reminder: Reminder)
}

protocol NewReminderSavedFromListDelegate: AnyObject {
    func didAddNewReminderFromList(reminder: Reminder)
}

final class ListPresenter {
    private weak var view: ListViewInterface?
    private var interactor: ListInteractorInterface
    private var router: ListRouterInterface
    private var reminderList: ReminderList
    private var delegate: ReminderDelegate?
    
    init(view: ListViewInterface, interactor: ListInteractorInterface, router: ListRouterInterface, reminderList: ReminderList, delegate: ReminderDelegate?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.reminderList = reminderList
        self.delegate = delegate
    }
}

extension ListPresenter: ListPresenterInterface {
    var numberOfRows: Int { reminderList.reminders.count }
    
    func viewDidLoad() {
        view?.configure(with: reminderList)
    }
    
    func cellForRowItemAt(_ row: Int) -> Reminder? {
        reminderList.reminders[safe: row]
    }
    
    func newReminderButtonTapped() {
        router.push(identifier: .addNewReminder, delegate: self)
    }
    
    func deleteActionTapped(at indexPath: IndexPath) {
        guard let reminder = reminderList.reminders[safe: indexPath.row] else { return }
        interactor.deleteReminder(reminder: reminder)
    }
}

extension ListPresenter: ListPresenterOutputInterface {
    func reminderDeleted(reminder: Reminder) {
        reminderList.reminders.removeAll(where: { $0.id == reminder.id })
        view?.reloadData()
        delegate?.didDeleteReminder(reminder: reminder)
    }
    
    func reminderDeleteFailed() {
        //show alert
    }
}

extension ListPresenter: ReminderDelegate {
    func didAddNewReminder(reminder: Reminder) {
        delegate?.didAddNewReminder(reminder: reminder)
        guard reminder.reminderListId == reminderList.id else { return }
        reminderList.reminders.append(reminder)
        view?.reloadData()
    }
    
    func didDeleteReminder(reminder: Reminder) {}
}
