import Foundation

protocol AddNewListViewControllerToPresenter {
    func viewDidLoad(listModel: ListModel)
    func cancelButtonTapped()
    func nameTextFieldChanged(_ text: String?)
    func numberOfItemsInSection(section: Int) -> Int
}

protocol AddNewListInteractorToPresenter {
    func newListSaved()
}

final class AddNewListPresenter {
    private weak var view: AddNewListPresenterToViewController?
    private let interactor: AddNewListPresenterToInteractor
    private let router: AddNewListPresenterToRouter
    private var newListModel: ListModel?
    
    init(view: AddNewListPresenterToViewController,
         interactor: AddNewListPresenterToInteractor,
         router: AddNewListPresenterToRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension AddNewListPresenter: AddNewListViewControllerToPresenter {

    func viewDidLoad(listModel: ListModel) {
        newListModel = listModel
        view?.configure()
    }
    
    func cancelButtonTapped() {
        router.dismiss()
    }
    
    func nameTextFieldChanged(_ text: String?) {
        guard let text = text else { return }
        newListModel?.name = text
        print(newListModel?.name)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        section == 0 ? 6 : 10
    }

}

extension AddNewListPresenter: AddNewListInteractorToPresenter {
    func newListSaved() {
        
    }
}
