import Foundation

protocol AddNewListInteractorInterface {
    func saveNewList(listModel: ListModel)
}

final class AddNewListInteractor {
    weak var presenter: AddNewListPresenterOutputInterface?
}

extension AddNewListInteractor: AddNewListInteractorInterface {
    func saveNewList(listModel: ListModel) {
        
    }
}
