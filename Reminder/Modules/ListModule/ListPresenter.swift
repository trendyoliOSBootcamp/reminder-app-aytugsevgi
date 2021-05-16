import Foundation

protocol ListPresenterInterface {
    func viewDidLoad()
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
    func viewDidLoad() {
        view?.configure(with: reminderList)
    }
    
    
}

extension ListPresenter: ListPresenterOutputInterface {
    
}
