import UIKit

final class HomeSearchResultsViewController: UIViewController {
    private var reminders = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(reminders: [Reminder]) {
        self.reminders = reminders
    }
}
