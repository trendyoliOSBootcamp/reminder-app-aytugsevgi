import Foundation

protocol HomeInteractorInterface {
    func fetchReminders()
    func fetchLists()
}

final class HomeInteractor {
    weak var output: HomePresenterOutputInterface?
    private let service = Service()
}

extension HomeInteractor: HomeInteractorInterface {
    func fetchReminders() {
        guard let reminders = service.fetchReminders() else { return }
        output?.remindersFetched(reminders: reminders)
    }
    
    func fetchLists() {
        guard let listModels = service.fetchList() else { return }
        output?.listFetched(listModels: listModels)
    }
}
