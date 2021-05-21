import UIKit

protocol ListViewInterface: AnyObject {
    func configure(with reminderList: ReminderList)
    func reloadData()
}

final class ListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var newReminderButton: UIButton!
    var presenter: ListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction private func newReminderButtonTapped(_ sender: Any) {
        presenter.newReminderButtonTapped()
    }
}

extension ListViewController: ListViewInterface {
    func configure(with reminderList: ReminderList) {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = String(reminderList.name)
        let titleAttributes = [NSAttributedString.Key.foregroundColor:
                                ListColor.init(rawValue: reminderList.color)?.color ?? UIColor.black]
        newReminderButton.tintColor = ListColor.init(rawValue: reminderList.color)?.color ?? UIColor.black
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController?.navigationBar.isTranslucent = true
        let backButton = UIBarButtonItem()
        backButton.title = ListConstant.backButtonTitle
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        tableView.register(reusableCellType: ReminderTableViewCell.self)
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = presenter.numberOfRows
        if numberOfRows == 0 {
            self.tableView.setEmptyMessage("No Reminders")
        } else {
            self.tableView.restore()
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: ReminderTableViewCell.self, for: indexPath)
        let reminder = presenter.cellForRowItemAt(indexPath.row)
        let viewModel = ReminderTableViewCellViewModel(contentText: reminder?.content,
                                                       isFlag: reminder?.isFlag,
                                                       priority: reminder?.priority)
        cell.configure(viewModel: viewModel)
        cell.selectionStyle = .none
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let detailsAction = UITableViewRowAction(style: .normal, title: "Details") { (rowAction, indexPath) in
            print("Details")
        }
        detailsAction.backgroundColor = .systemGray3
        
        let flagAction = UITableViewRowAction(style: .normal, title: "Flag") { (rowAction, indexPath) in
            print("Flag")
            self.presenter.flagActionTapped(at: indexPath)
        }
        flagAction.backgroundColor = .systemOrange

        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete")  { (rowAction, indexPath) in
            print("delete")
            self.presenter.deleteActionTapped(at: indexPath)
        }
        deleteAction.backgroundColor = .red

        return [deleteAction, flagAction, detailsAction]
    }
}



