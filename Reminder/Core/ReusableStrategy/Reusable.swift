import UIKit

protocol Reusable {
    func isSatisfy(section: Int, viewModels: [Any]?) -> Bool
    func execute(collectionView: UICollectionView, indexPath: IndexPath, viewModels: [Any]?) -> UICollectionViewCell
}

