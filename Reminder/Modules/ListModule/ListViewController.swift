import UIKit

protocol ListViewInterface: AnyObject {
    
}

final class ListViewController: UIViewController {
    var presenter: ListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListViewController: ListViewInterface {
    
}
