//
//  ReminderTableViewCell.swift
//  Reminder
//
//  Created by aytug on 19.05.2021.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
    @IBOutlet private weak var checkBoxButton: UIButton!
    @IBOutlet private weak var reminderContentLabel: UILabel!
    @IBOutlet private weak var flagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxButton.layer.cornerRadius = checkBoxButton.frame.height / 2
        checkBoxButton.layer.borderWidth = CGFloat(ListConstant.checkBoxButtonBorderWidth)
        checkBoxButton.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func configure(viewModel: ReminderTableViewCellViewModel) {
        guard let contentText = viewModel.contentText,
              let isFlag = viewModel.isFlag,
              let exclamationMark = viewModel.priority?.exclamationMark else { return }
        let reminderAttributedString = NSMutableAttributedString()
        let priorityTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        let contentTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let priorityAttributedString = NSAttributedString(string: exclamationMark, attributes: priorityTextAttributes)
        let contentAttributedString = NSAttributedString(string: " \(contentText)", attributes: contentTextAttributes)
        reminderAttributedString.append(priorityAttributedString)
        reminderAttributedString.append(contentAttributedString)
        reminderContentLabel.attributedText = reminderAttributedString
        flagImageView.image = isFlag ? UIImage(systemName: ListConstant.flagImageSystemNameFill) : UIImage(systemName: ListConstant.flagImageSystemName)
    }
}
