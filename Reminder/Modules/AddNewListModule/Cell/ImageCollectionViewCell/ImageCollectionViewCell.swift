import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!
    
    func configure(viewModel: ImageCollectionViewCellViewModel) {
        makeCircle
        backgroundColor = viewModel.backgroundColor
        imageView.image = viewModel.image
    }
}
