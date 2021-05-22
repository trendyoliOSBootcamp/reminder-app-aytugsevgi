import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!
    
    func configure(viewModel: ImageCollectionViewCellViewModel) {
        makeCircle
        backgroundColor = viewModel.backgroundColor
        imageView.image = viewModel.image
    }
    
    func selectedDisplay() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    func deselectedDisplay() {
        layer.borderWidth = .zero
    }
}
