import UIKit

extension UITableView {
    func register(reusableCellType: UITableViewCell.Type) {
        self.register(reusableCellType.nib, forCellReuseIdentifier: reusableCellType.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
}
