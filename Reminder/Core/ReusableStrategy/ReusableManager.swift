import UIKit

class ReusableManager {
    static let shared = ReusableManager()
    private let items: [Reusable] = [ColorViewCellReusable(), ImageViewCellReusable()]
    
    func dequeueReusableCell(collectionView: UICollectionView, indexPath: IndexPath, viewModels: [Any]) -> UICollectionViewCell? {
        items.first(where: {$0.isSatisfy(section: indexPath.section, viewModels: viewModels)})?.execute(collectionView: collectionView, indexPath: indexPath, viewModels: viewModels)
    }
}

