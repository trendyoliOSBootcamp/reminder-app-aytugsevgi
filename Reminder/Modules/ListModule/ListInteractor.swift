import Foundation

protocol ListInteractorInterface {
    
}

final class ListInteractor {
    weak var output: ListPresenterOutputInterface?
    
}

extension ListInteractor: ListInteractorInterface {
    
}
