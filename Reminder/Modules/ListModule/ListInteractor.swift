import Foundation

protocol ListInteractorInterface {
    func deleteReminder(reminder: Reminder)
}

final class ListInteractor {
    private let service = Service()
    weak var output: ListPresenterOutputInterface?
    
}

extension ListInteractor: ListInteractorInterface {
    func deleteReminder(reminder: Reminder) {
        do {
            try service.deleteReminder(reminder: reminder)
            output?.reminderDeleted(reminder: reminder)
        } catch let error {
            output?.reminderDeleteFailed()
        }
    }
}
