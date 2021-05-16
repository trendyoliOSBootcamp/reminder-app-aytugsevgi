protocol AddNewReminderInteractorInterface {
    func fetchRemainderList()
}

final class AddNewReminderInteractor {
    private let service = Service()
    weak var output: AddNewReminderOutputInterface?
}

extension AddNewReminderInteractor: AddNewReminderInteractorInterface {
    func fetchRemainderList() {
        guard let list = service.fetchList() else { return }
        output?.listFetched(listModels: list)
    }
}
