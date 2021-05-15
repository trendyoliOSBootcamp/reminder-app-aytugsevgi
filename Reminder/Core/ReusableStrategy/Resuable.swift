import UIKit
/*
 Henüz nasıl data paslayacağımı çözemedim.
 Şu an kullanmıyorum. Fakat yakın tarihte kullanıma hazır olacaktır :P
 Hazır olduktan sonra class'lar ayrı dosyalara parçalanacak.
 */
protocol Reusable {
    func isSatisfy(section: Int) -> Bool
    func execute(collectionView: UICollectionView, indexPath: IndexPath, params: Any) -> UICollectionViewCell
}

class ImageViewCellReusable: Reusable {
    func isSatisfy(section: Int) -> Bool {
        section == 1
    }
    
    func execute(collectionView: UICollectionView, indexPath: IndexPath, params: Any) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ImageCollectionViewCell.self, for: indexPath)
        guard let params = params as? ImageCollectionViewCellViewModel else { return cell }
        cell.configure(viewModel: params)
        return cell
    }
}

class ColorViewCellReusable: Reusable {
    func isSatisfy(section: Int) -> Bool {
        section == 0
    }
    
    func execute(collectionView: UICollectionView, indexPath: IndexPath, params: Any) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ColorCollectionViewCell.self, for: indexPath)
        guard let params = params as? ColorCollectionViewCellViewModel else { return cell }
        cell.configure(viewModel: params)
        return cell
    }
}

class ReusableManager {
    static let shared = ReusableManager()
    private let items: [Reusable] = [ColorViewCellReusable(), ImageViewCellReusable()]
    
    func dequeueReusableCell(section: Int, collectionView: UICollectionView, indexPath: IndexPath, params: Any) -> UICollectionViewCell? {
        items.first(where: {$0.isSatisfy(section: section)})?.execute(collectionView: collectionView, indexPath: indexPath, params: params)
    }
}
