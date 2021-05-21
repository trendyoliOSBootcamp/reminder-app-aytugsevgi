import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view: UIView!
    func configure(viewModel: ColorCollectionViewCellViewModel) {
        makeCircle
        view.makeCircle
        view.backgroundColor = viewModel.backgroundColor
    }
    
    func selectedDisplay() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    func deselectedDisplay() {
        layer.borderWidth = 0
    }
}
