import UIKit

extension UITableView {
    func register(reusableCellType: UITableViewCell.Type) {
        self.register(reusableCellType.nib, forCellReuseIdentifier: reusableCellType.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                 width: self.bounds.size.width,
                                                 height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .systemGray3
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "System", size: 20)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
