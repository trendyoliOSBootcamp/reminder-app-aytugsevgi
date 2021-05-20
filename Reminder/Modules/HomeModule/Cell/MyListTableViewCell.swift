import UIKit

class MyListTableViewCell: UITableViewCell {
    @IBOutlet private weak var listImageView: UIImageView!
    @IBOutlet private weak var listImageViewBackgroundView: UIView!
    @IBOutlet private weak var listNameLabel: UILabel!
    @IBOutlet private weak var remainderCountLabel: UILabel!
    
    func configure(remainderList: ReminderList) {
        listImageViewBackgroundView.makeCircle
        listImageViewBackgroundView.backgroundColor = .clear
        let color = ListColor(rawValue: remainderList.color)
        let imageName = remainderList.image
        let name = remainderList.name
        let reminders = remainderList.reminders
        listImageViewBackgroundView.applyThreeDimensionEffect(color: color?.color)
        listImageView.image = UIImage(systemName: imageName)
        listNameLabel.text = name
        remainderCountLabel.text = String(reminders.count)
    }
}
