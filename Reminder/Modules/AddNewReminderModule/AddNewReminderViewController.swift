import UIKit

protocol AddNewReminderViewInterface: AnyObject {
    
}

final class AddNewReminderViewController: UIViewController {
    var presenter: AddNewReminderPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddNewReminderViewController: AddNewReminderViewInterface {
    
}
