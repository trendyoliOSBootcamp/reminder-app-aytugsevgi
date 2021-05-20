//
//  SearchTableViewCell.swift
//  Reminder
//
//  Created by aytug on 20.05.2021.
//

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
        let priorityAttributedString = NSAttributedString(string: reminder.priority.exclamationMark, attributes: priorityTextAttributes)
        let contentAttributedString = NSAttributedString(string: " \(reminder.content)", attributes: contentTextAttributes)
        reminderAttributedString.append(priorityAttributedString)
        reminderAttributedString.append(contentAttributedString)
        contentLabel.attributedText = reminderAttributedString
        flagImageView.image = reminder.isFlag ? UIImage(systemName: ListConstant.flagImageSystemNameFill) : UIImage(systemName: ListConstant.flagImageSystemName)
        if isLast {
            seperatorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                seperatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            ])
        }
    }
}
