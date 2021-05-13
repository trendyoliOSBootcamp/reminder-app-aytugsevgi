import Foundation

protocol HomePresenterToInteractor {
    func fetchReminders()
}

final class HomeInteractor {
    var presenter: HomeInteractorToPresenter?
}

extension HomeInteractor: HomePresenterToInteractor {
    func fetchReminders() {
        
    }
}
