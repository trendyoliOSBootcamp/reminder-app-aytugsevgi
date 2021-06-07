import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet private weak var checkBoxButton: UIButton!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxButton.layer.cornerRadius = checkBoxButton.frame.height / 2
        checkBoxButton.layer.borderWidth = CGFloat(ListConstant.checkBoxButtonBorderWidth)
        checkBoxButton.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func configure(reminder: Reminder, isLast: Bool) {
        let reminderAttributedString = NSMutableAttributedString()
        let priorityTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        let contentTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let space = reminder.priority.exclamationMark.isEmpty ? "" : " "
        let priorityAttributedString = NSAttributedString(string: reminder.priority.exclamationMark, attributes: priorityTextAttributes)
        let contentAttributedString = NSAttributedString(string: "\(space)\(reminder.content)", attributes: contentTextAttributes)
        reminderAttributedString.append(priorityAttributedString)
        reminderAttributedString.append(contentAttributedString)
        contentLabel.attributedText = reminderAttributedString
        flagImageView.image = reminder.isFlag ? UIImage(systemName: ListConstant.flagImageSystemNameFill) : UIImage()
        configureSeperator(isFullWidth: isLast)
    }
    
    private func configureSeperator(isFullWidth: Bool) {
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.removeConstraints(seperatorView.constraints)
        contentView.removeConstraints( contentView.constraints.filter {
            $0.firstItem as? UIView == seperatorView || $0.secondItem as? UIView == seperatorView
        })
        if isFullWidth {
            NSLayoutConstraint.activate([
                seperatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                seperatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                seperatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                seperatorView.heightAnchor.constraint(equalToConstant: 1)
                
            ])
        } else {
            NSLayoutConstraint.activate([
                seperatorView.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
                seperatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                seperatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                seperatorView.heightAnchor.constraint(equalToConstant: 1)
                
            ])
        }
    }
}
