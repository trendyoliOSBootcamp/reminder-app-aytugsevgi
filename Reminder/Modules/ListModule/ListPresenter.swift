import Foundation

protocol ListPresenterInterface {
    var numberOfRows: Int { get }
    
    func viewDidLoad()
    func cellForRowItemAt(_ row: Int) -> Reminder?
    func newReminderButtonTapped()
}

protocol ListPresenterOutputInterface: AnyObject {
    
}

protocol NewReminderSavedFromListDelegate: AnyObject {
    func didAddNewReminderFromList(reminder: Reminder)
}

final class ListPresenter {
    private weak var view: ListViewInterface?
    private var interactor: ListInteractorInterface
    private var router: ListRouterInterface
    private var reminderList: ReminderList
    private var delegate: NewReminderSavedDelegate?
    
    init(view: ListViewInterface, interactor: ListInteractorInterface, router: ListRouterInterface, reminderList: ReminderList, delegate: NewReminderSavedDelegate?) {
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
}

extension ListPresenter: ListPresenterOutputInterface {
    
}

extension ListPresenter: NewReminderSavedDelegate {
    func didAddNewReminder(reminder: Reminder) {
        delegate?.didAddNewReminder(reminder: reminder)
        guard reminder.reminderListId == reminderList.id else { return }
        reminderList.reminders.append(reminder)
        view?.reloadData()
    }
}
