import Foundation

protocol AddNewReminderPresenterInterface {
    
}

protocol AddNewReminderOutputInterface: AnyObject {
    
}

final class AddNewReminderPresenter {
    private weak var view: AddNewReminderViewInterface?
    private var interactor: AddNewReminderInteractorInterface
    private var router: AddNewReminderRouterInterface
    
    init(view: AddNewReminderViewInterface, interactor: AddNewReminderInteractorInterface,
         router: AddNewReminderRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension AddNewReminderPresenter: AddNewReminderPresenterInterface {
    
}

extension AddNewReminderPresenter: AddNewReminderOutputInterface {
    
}
