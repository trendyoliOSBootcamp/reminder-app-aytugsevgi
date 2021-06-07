import Foundation

protocol AddNewListInteractorInterface {
    func saveNewList(reminderList: ReminderList)
}

final class AddNewListInteractor {
    private let service = Service()
    weak var output: AddNewListPresenterOutputInterface?
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
