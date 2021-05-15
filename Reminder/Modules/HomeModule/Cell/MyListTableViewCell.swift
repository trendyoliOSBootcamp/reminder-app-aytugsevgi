import UIKit

class MyListTableViewCell: UITableViewCell {
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var listImageViewBackgroundView: UIView!
    
    func configure() {
        listImageViewBackgroundView.makeCircle
        listImageViewBackgroundView.backgroundColor = .clear
        listImageViewBackgroundView.applyThreeDimensionEffect(color: .systemOrange)
    }
}
