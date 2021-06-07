import UIKit

class ColorViewCellReusable: Reusable {
    func isSatisfy(section: Int, viewModels: [Any]?) -> Bool {
        section == 0 && ((viewModels?.first(where: { $0 is ColorCollectionViewCellViewModel })) != nil)
    }
    
    func execute(collectionView: UICollectionView, indexPath: IndexPath, viewModels: [Any]?) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ColorCollectionViewCell.self, for: indexPath)
        guard let viewModel = viewModels?.first(where: { $0 is ColorCollectionViewCellViewModel }),
              let colorViewModel = viewModel as? ColorCollectionViewCellViewModel else { return cell }
        cell.configure(viewModel: colorViewModel)
        return cell
    }
}
