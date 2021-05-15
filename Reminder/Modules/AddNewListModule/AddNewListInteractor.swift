import Foundation

protocol AddNewListPresenterToInteractor {
    func saveNewList(listModel: ListModel)
}

final class AddNewListInteractor {
    weak var presenter: AddNewListInteractorToPresenter?
}

extension AddNewListInteractor: AddNewListPresenterToInteractor {
    func saveNewList(listModel: ListModel) {
        
    }
}
