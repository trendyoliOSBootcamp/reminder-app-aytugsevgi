import Foundation

protocol AddNewListInteractorInterface {
    func saveNewList(reminderList: ReminderList)
}

final class AddNewListInteractor {
    weak var output: AddNewListPresenterOutputInterface?
    private let service = Service()
}

extension AddNewListInteractor: AddNewListInteractorInterface {
    func saveNewList(reminderList: ReminderList) {
        
        do {
            try service.saveList(reminderList: reminderList)
            output?.newListSaved(savedReminderList: reminderList)
        } catch let error {
            output?.newListSaveFailed(error: error.localizedDescription)
        }
        
        
        
    }
}
