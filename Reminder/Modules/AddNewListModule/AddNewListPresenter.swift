import Foundation

protocol AddNewListViewControllerToPresenter {
    var numberOfSections: Int { get }
    var numberOfItemsInSection: Int { get }
    
    func viewDidLoad()
    func cancelButtonTapped()
    func nameTextFieldChanged(_ text: String?)
    func sizeForItem(width: Double, minimumLineSpacing: Double, sectionInsetLeft: Double, sectionInsetRight: Double) -> Size
    func colorForItem(at index: Int) -> ListColor
    func imageForItem(at index: Int) -> String
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
    private var colorsForCell: [ListColor] = [.systemBlue, .red, .brown, .systemGray2, .systemGreen, .systemIndigo,
                                              .systemOrange, .systemPink, .systemPurple, .systemRed, .systemTeal,
                                              .systemYellow]
    private var imagesForCell: [String] = ["list.bullet", "bookmark.fill", "pin.fill", "gift.fill", "folder.fill",
                                           "paperplane.fill", "person.fill", "cloud.fill", "powersleep",
                                           "person.2.fill", "calendar", "doc.fill"]
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
    var numberOfItemsInSection: Int { 12 }
    
    func viewDidLoad() {
        view?.configure()
        view?.setImageViewBackgroundColor(color: colorsForCell.first!.color)
        view?.setImage(name: imagesForCell.first!)
    }
    
    func cancelButtonTapped() {
        router.dismiss()
    }
    
    func nameTextFieldChanged(_ text: String?) {
        guard let text = text else { return }
        newListModel?.name = text
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
    
    func imageForItem(at index: Int) -> String {
        return imagesForCell[index]
    }
    
    func didSelectItemAt(section: Int, item: Int) {
        section == 0 ? view?.setImageViewBackgroundColor(color: colorsForCell[item].color) : view?.setImage(name: imagesForCell[item])
    }
}

extension AddNewListPresenter: AddNewListInteractorToPresenter {
    func newListSaved() {
        
    }
}
