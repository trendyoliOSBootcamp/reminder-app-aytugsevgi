import UIKit

class ImageViewCellReusable: Reusable {
    func isSatisfy(section: Int, viewModels: [Any]?) -> Bool {
        section == 1 && ((viewModels?.first(where: { $0 is ImageCollectionViewCellViewModel })) != nil)
    }
    
    func execute(collectionView: UICollectionView, indexPath: IndexPath, viewModels: [Any]?) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ImageCollectionViewCell.self, for: indexPath)
        guard let viewModel = viewModels?.first(where: { $0 is ImageCollectionViewCellViewModel }),
              let imageViewModel = viewModel as? ImageCollectionViewCellViewModel else { return cell }
        cell.configure(viewModel: imageViewModel)
        return cell
    }
}
