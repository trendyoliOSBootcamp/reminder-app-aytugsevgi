import Foundation

protocol HomePresenterToInteractor {
    func fetchReminders()
    func fetchLists()
}

final class HomeInteractor {
    var presenter: HomeInteractorToPresenter?
    private let service = Service()
}

extension HomeInteractor: HomePresenterToInteractor {
    func fetchReminders() {
        
    }
    
    func fetchLists() {
        guard let listModels = service.fetchList() else { return }
        presenter?.listFetched(listModels: listModels)
    }
}
