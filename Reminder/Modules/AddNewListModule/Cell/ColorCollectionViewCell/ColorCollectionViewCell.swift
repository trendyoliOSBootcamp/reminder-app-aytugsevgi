import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    func configure(viewModel: ColorCollectionViewCellViewModel) {
        makeCircle()
        backgroundColor = viewModel.backgroundColor
    }

}
