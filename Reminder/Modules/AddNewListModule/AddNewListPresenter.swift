import Foundation

protocol NewReminderListSavedDelegate: AnyObject {
    func newReminderListDidSaved(savedReminderList: ReminderList)
}

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
    func doneButtonTapped()
}

protocol AddNewListPresenterOutputInterface: AnyObject {
    func newListSaved(savedReminderList: ReminderList)
    func newListSaveFailed(error: String)
}

typealias Size = (width: Double, height: Double)
typealias SelectedReminderList = (name: String, color: Int, image: String)

final class AddNewListPresenter {
    private weak var view: AddNewListViewInterface?
    private let interactor: AddNewListInteractorInterface
    private let router: AddNewListRouterInterface
    private var colorsForCell: [ListColor] = [.systemBlue, .red, .brown, .systemGray2, .systemGreen, .systemIndigo,
                                              .systemOrange, .systemPink, .systemPurple, .systemRed, .systemTeal,
                                              .systemYellow]
    private var imagesForCell: [String] = ["list.bullet", "bookmark.fill", "pin.fill", "gift.fill", "folder.fill",
                                           "paperplane.fill", "person.fill", "cloud.fill", "powersleep",
                                           "person.2.fill", "calendar", "doc.fill"]
    private var selectedReminderList = SelectedReminderList(name: "", color: 0, image: "")
    private weak var delegate: NewReminderListSavedDelegate?
    
    init(view: AddNewListViewInterface,
         interactor: AddNewListInteractorInterface,
         router: AddNewListRouterInterface,
         delegate: NewReminderListSavedDelegate) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
    }
}

extension AddNewListPresenter: AddNewListPresenterInterface {
    var numberOfSections: Int { AddNewListConstant.numberOfSections }
    
    func numberOfItemsInSection(at section: Int) -> Int {
        section == .zero ? colorsForCell.count : imagesForCell.count
    }
    
    func viewDidLoad() {
        view?.configure()
        guard let color = colorsForCell.first,
              let imageName = imagesForCell.first else { return }
        let name = AddNewListConstant.initialRemainderListName
        selectedReminderList.name = name
        selectedReminderList.color = color.rawValue
        selectedReminderList.image = imageName
        view?.setImageViewBackgroundColor(color: color.color)
        view?.setImage(name: imageName)
        view?.setTextFieldTextColor(color: color.color)
        view?.setTextFieldText(text: name)
    }
    
    func cancelButtonTapped() {
        router.dismiss()
    }
    
    func nameTextFieldChanged(text: String?) {
        guard let text = text else { return }
        selectedReminderList.name = text
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
            guard let color = colorsForCell[safe: indexPath.item] else { return }
            selectedReminderList.color = color.rawValue
            view?.setImageViewBackgroundColor(color: color.color)
            view?.setTextFieldTextColor(color: color.color)
        } else {
            guard let imageName = imagesForCell[safe: indexPath.item] else { return }
            selectedReminderList.image = imageName
            view?.setImage(name: imageName)
        }
    }
    
    func doneButtonTapped() {
        let name = selectedReminderList.name
        let color = selectedReminderList.color
        let image = selectedReminderList.image
        let reminderList = ReminderList(id: UUID(), name: name, color: color, image: image, reminders: [])
        interactor.saveNewList(reminderList: reminderList)
    }
}

extension AddNewListPresenter: AddNewListPresenterOutputInterface {
    func newListSaved(savedReminderList: ReminderList) {
        delegate?.newReminderListDidSaved(savedReminderList: savedReminderList)
        router.dismiss()
    }
    
    func newListSaveFailed(error: String) {
        router.showAlert(title: "Error", message: error)
    }
}


