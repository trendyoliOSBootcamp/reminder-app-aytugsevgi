import Foundation

protocol ListPresenterInterface {
    var numberOfRows: Int { get }
    
    func viewDidLoad()
    func cellForRowItemAt(_ row: Int) -> Reminder?
}

protocol ListPresenterOutputInterface: AnyObject {
    
}

final class ListPresenter {
    private weak var view: ListViewInterface?
    private var interactor: ListInteractorInterface
    private var router: ListRouterInterface
    private var reminderList: ReminderList
    
    init(view: ListViewInterface, interactor: ListInteractorInterface, router: ListRouterInterface, reminderList: ReminderList) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.reminderList = reminderList
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
}

extension ListPresenter: ListPresenterOutputInterface {
    
}
