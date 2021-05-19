import UIKit

protocol ListViewInterface: AnyObject {
    func configure(with reminderList: ReminderList)
}

final class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: ListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ListViewController: ListViewInterface {
    func configure(with reminderList: ReminderList) {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = String(reminderList.name)
        let titleAttributes = [NSAttributedString.Key.foregroundColor:
                                ListColor.init(rawValue: reminderList.color)?.color ?? UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController?.navigationBar.isTranslucent = true
        let backButton = UIBarButtonItem()
        backButton.title = ListConstant.backButtonTitle
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        tableView.register(reusableCellType: ReminderTableViewCell.self)
        tableView.contentInsetAdjustmentBehavior = .never
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
