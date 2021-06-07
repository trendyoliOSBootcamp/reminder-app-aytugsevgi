protocol AddNewReminderInteractorInterface {
    func fetchReminderList()
    func saveReminder(reminder: Reminder) 
}

final class AddNewReminderInteractor {
    private let service = Service()
    weak var output: AddNewReminderOutputInterface?
}

extension AddNewReminderInteractor: AddNewReminderInteractorInterface {
    func fetchReminderList() {
        guard let list = service.fetchList() else { return }
        output?.listFetched(listModels: list)
    }
    
    func saveReminder(reminder: Reminder) {
        do {
            try service.saveReminder(reminder: reminder)
            output?.reminderSaved(reminder: reminder)
        } catch let error {
            output?.reminderSaveFailed(error: error.localizedDescription)
        }
    }
}
