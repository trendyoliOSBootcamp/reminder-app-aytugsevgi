import Foundation

protocol AddNewListPresenterToInteractor {
    func saveNewList(listModel: ListModel)
}

final class AddNewListInteractor {
    var presenter: AddNewListInteractorToPresenter?
}

extension AddNewListInteractor: AddNewListPresenterToInteractor {
    func saveNewList(listModel: ListModel) {
        
    }
}
