import Foundation

protocol AddNewListPresenterInterface {
    var numberOfSections: Int { get }
    
    func numberOfItemsInSection(at section: Int) -> Int
    func viewDidLoad()
    func cancelButtonTapped()
    func nameTextFieldChanged(text: String?)
    func sizeForItem(width: Double, minimumLineSpacing: Double, sectionInsetLeft: Double, sectionInsetRight: Double) -> Size
    func colorForItem(at index: Int) -> ListColor?
    func imageForItem(at index: Int) -> String?
    func didSelectItemAt(indexPath: IndexPath)
}

protocol AddNewListPresenterOutputInterface: AnyObject {
    func newListSaved()
}

typealias Size = (width: Double, height: Double)

final class AddNewListPresenter {
    private weak var view: AddNewListViewInterface?
    private let interactor: AddNewListInteractorInterface
    private let router: AddNewListRouterInterface
    private var newListModel: ListModel?
    private var colorsForCell: [ListColor] = [.systemBlue, .red, .brown, .systemGray2, .systemGreen, .systemIndigo,
                                              .systemOrange, .systemPink, .systemPurple, .systemRed, .systemTeal,
                                              .systemYellow]
    private var imagesForCell: [String] = ["list.bullet", "bookmark.fill", "pin.fill", "gift.fill", "folder.fill",
                                           "paperplane.fill", "person.fill", "cloud.fill", "powersleep",
                                           "person.2.fill", "calendar", "doc.fill"]
    init(view: AddNewListViewInterface,
         interactor: AddNewListInteractorInterface,
         router: AddNewListRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension AddNewListPresenter: AddNewListPresenterInterface {
    var numberOfSections: Int { AddNewListConstant.numberOfSections }
    
    func numberOfItemsInSection(at section: Int) -> Int {
        section == 0 ? colorsForCell.count : imagesForCell.count
    }
    
    func viewDidLoad() {
        view?.configure()
        guard let color = colorsForCell.first?.color,
              let name = imagesForCell.first else { return }
        view?.setImageViewBackgroundColor(color: color)
        view?.setImage(name: name)
        view?.setTextFieldTextColor(color: color)
    }
    
    func cancelButtonTapped() {
        router.dismiss()
    }
    
    func nameTextFieldChanged(text: String?) {
        guard let text = text else { return }
        newListModel?.name = text
    }
    
    func sizeForItem(width: Double, minimumLineSpacing: Double, sectionInsetLeft: Double, sectionInsetRight: Double) -> Size {
        let lineSpacingCount = Double(AddNewListConstant.numberOfItemInLine - 1)
        let totalLineSpacing = minimumLineSpacing * lineSpacingCount + sectionInsetLeft + sectionInsetRight
        let cellWidth = (width - totalLineSpacing) / Double(AddNewListConstant.numberOfItemInLine)
        let cellHeight = cellWidth
        return Size(width: cellWidth, height: cellHeight)
    }
    
    func colorForItem(at index: Int) -> ListColor? {
        return colorsForCell[safe: index]
    }
    
    func imageForItem(at index: Int) -> String? {
        return imagesForCell[safe: index]
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        if indexPath.section == 0 {
            let color = colorsForCell[safe: indexPath.item]?.color
            view?.setImageViewBackgroundColor(color: color)
            view?.setTextFieldTextColor(color: color)
        } else {
            view?.setImage(name: imagesForCell[safe: indexPath.item])
        }
    }
}

extension AddNewListPresenter: AddNewListPresenterOutputInterface {
    func newListSaved() {
        
    }
}
