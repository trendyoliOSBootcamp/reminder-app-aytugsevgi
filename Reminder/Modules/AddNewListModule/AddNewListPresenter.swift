import Foundation

protocol AddNewListViewControllerToPresenter {
    var numberOfSections: Int { get }
    
    func viewDidLoad()
    func cancelButtonTapped()
    func nameTextFieldChanged(_ text: String?)
    func numberOfItemsInSection(section: Int) -> Int
    func sizeForItem(width: Double, minimumLineSpacing: Double, sectionInsetLeft: Double, sectionInsetRight: Double) -> Size
    func colorForItem(at index: Int) -> ListColor
    func imageForItem(at index: Int)
    func didSelectItemAt(section: Int, item: Int)
}

protocol AddNewListInteractorToPresenter {
    func newListSaved()
}

typealias Size = (width: Double, height: Double)

final class AddNewListPresenter {
    private weak var view: AddNewListPresenterToViewController?
    private let interactor: AddNewListPresenterToInteractor
    private let router: AddNewListPresenterToRouter
    private var newListModel: ListModel?
    private var colorsForCell: [ListColor] = [.systemBlue, .cyan, .brown, .systemGray2, .systemGreen, .systemIndigo,
                                              .systemOrange, .systemPink, .systemPurple, .systemRed, .systemTeal, .systemYellow]
    
    init(view: AddNewListPresenterToViewController,
         interactor: AddNewListPresenterToInteractor,
         router: AddNewListPresenterToRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension AddNewListPresenter: AddNewListViewControllerToPresenter {
    var numberOfSections: Int { 2 }
    
    func viewDidLoad() {
        view?.configure()
        view?.setImageViewBackgroundColor(color: colorsForCell.first!.color)
    }
    
    func cancelButtonTapped() {
        router.dismiss()
    }
    
    func nameTextFieldChanged(_ text: String?) {
        guard let text = text else { return }
        newListModel?.name = text
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        section == 0 ? 12 : 12
    }
    
    func sizeForItem(width: Double, minimumLineSpacing: Double, sectionInsetLeft: Double, sectionInsetRight: Double) -> Size {
        let totalLineSpacing = minimumLineSpacing * 5 + sectionInsetLeft + sectionInsetRight
        let cellWidth = (width - totalLineSpacing) / 6
        let cellHeight = cellWidth
        return Size(width: cellWidth, height: cellHeight)
    }
    
    func colorForItem(at index: Int) -> ListColor {
        return colorsForCell[index]
    }
    
    func imageForItem(at: Int) {
        
    }
    
    func didSelectItemAt(section: Int, item: Int) {
        if section == 0 {
            view?.setImageViewBackgroundColor(color: colorsForCell[item].color)
        }
    }

}

extension AddNewListPresenter: AddNewListInteractorToPresenter {
    func newListSaved() {
        
    }
}
