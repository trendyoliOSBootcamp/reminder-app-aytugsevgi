import Foundation

protocol NewReminderSavedDelegate: AnyObject {
    func didReminderSave(reminder: Reminder)
}

protocol AddNewReminderPresenterInterface {
    var numberOfRowsInComponent: Int { get }
    var numberOfComponents: Int { get }
    
    func viewDidLoad()
    func titleForRow(at row: Int) -> String?
    func priorityButtonTapped()
    func listButtonTapped()
    func cancelButtonTapped()
    func addButtonTapped(title: String?, content: String, isFlag: Bool)
    func pickerDoneButtonTapped()
    func didSelectRow(row: Int)
}

typealias NewReminder = (title: String, content: String, list: ReminderList, isFlag: Bool, priority: Priority)

protocol AddNewReminderOutputInterface: AnyObject {
    func listFetched(listModels: [ReminderList])
    func reminderSaved(reminder: Reminder)
}

final class AddNewReminderPresenter {
    private weak var view: AddNewReminderViewInterface?
    private var interactor: AddNewReminderInteractorInterface
    private var router: AddNewReminderRouterInterface
    private var pickerType: PickerType = .none
    private var reminderList = [ReminderList]()
    private var newReminder: NewReminder?
    private var priorities: [Priority] = [.none, .normal, .low, .medium, .high]
    private weak var delegate: NewReminderSavedDelegate?
    
    init(view: AddNewReminderViewInterface, interactor: AddNewReminderInteractorInterface,
         router: AddNewReminderRouterInterface, delegate: NewReminderSavedDelegate) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
    }
}

extension AddNewReminderPresenter: AddNewReminderPresenterInterface {
    var numberOfComponents: Int { 1 }
    var numberOfRowsInComponent: Int {
        switch pickerType {
        case .list:
            return reminderList.count
        case .priority:
            return priorities.count
        default:
            return 0
        }
    }
    
    func viewDidLoad() {
        view?.configure()
        interactor.fetchReminderList()
    }
    
    func priorityButtonTapped() {
        guard pickerType != .priority else { return }
        pickerType = .priority
        view?.setPickerViewNameLabelText(text: pickerType.rawValue)
        view?.openPicker()
    }
    
    func listButtonTapped() {
        guard pickerType != .list else { return }
        pickerType = .list
        view?.setPickerViewNameLabelText(text: pickerType.rawValue)
        view?.openPicker()
    }
    
    func addButtonTapped(title: String?, content: String, isFlag: Bool) {
        guard let title = title, !title.isEmpty, !content.isEmpty,
              let listId = newReminder?.list.id, let priority = newReminder?.priority else {
            router.dismiss { self.router.showAlert(title: "Didn't Save", message: "Any area can't be empty!") }
            return
        }
        newReminder?.title = title
        newReminder?.content = content
        newReminder?.isFlag = isFlag
        let reminder = Reminder(id: UUID(), reminderListId: listId, title: title,
                                content: content, isFlag: isFlag, priority: priority)
        interactor.saveReminder(reminder: reminder)
        
    }
    
    func cancelButtonTapped() {
        router.dismiss(completion: nil)
    }
    
    func titleForRow(at row: Int) -> String? {
        pickerType == PickerType.priority ?  priorities[safe: row]?.string : reminderList[safe: row]?.name
    }
    
    func pickerDoneButtonTapped() {
        view?.closePicker { _ in
            self.pickerType = .none
        }
    }
    
    func didSelectRow(row: Int) {
        guard pickerType == .list, let list = reminderList[safe: row] else {
            guard let priority = Priority(rawValue: row) else { return }
            newReminder?.priority = priority
            view?.setPriorityLabelText(text: priority.string)
            return
        }
        newReminder?.list = list
        view?.setListLabelText(text: list.name)
    }
    
}

extension AddNewReminderPresenter: AddNewReminderOutputInterface {
    func listFetched(listModels: [ReminderList]) {
        reminderList = listModels
        guard let first = reminderList.first else { return }
        newReminder = NewReminder(title: "", content: "", list: first, isFlag: false, priority: Priority.none)
        view?.setListLabelText(text: newReminder?.list.name)
        view?.setPriorityLabelText(text: newReminder?.priority.string)
    }
    
    func reminderSaved(reminder: Reminder) {
        delegate?.didReminderSave(reminder: reminder)
        router.dismiss(completion: nil)
    }
}
