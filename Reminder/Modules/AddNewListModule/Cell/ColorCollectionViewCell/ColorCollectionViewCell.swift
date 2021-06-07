import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!

    override func draw(_ rect: CGRect) {
        colorView.makeCircle
        makeCircle
    }
    
    func configure(viewModel: ColorCollectionViewCellViewModel) {
        colorView.backgroundColor = viewModel.backgroundColor
    }
    
    func selectedDisplay() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    func deselectedDisplay() {
        layer.borderWidth = 0
    }
}
