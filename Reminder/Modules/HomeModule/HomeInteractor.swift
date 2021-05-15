import Foundation

protocol HomeInteractorInterface {
    func fetchReminders()
    func fetchLists()
}

final class HomeInteractor {
    var output: HomePresenterOutputInterface?
    private let service = Service()
}

extension HomeInteractor: HomeInteractorInterface {
    func fetchReminders() {
        
    }
    
    func fetchLists() {
        guard let listModels = service.fetchList() else { return }
        output?.listFetched(listModels: listModels)
    }
}
