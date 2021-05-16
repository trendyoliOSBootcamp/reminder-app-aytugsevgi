import UIKit

protocol ListViewInterface: AnyObject {
    func configure(with reminderList: ReminderList)
}

final class ListViewController: UIViewController {
    var presenter: ListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListViewController: ListViewInterface {
    func configure(with reminderList: ReminderList) {
        print(reminderList)
    }
}
