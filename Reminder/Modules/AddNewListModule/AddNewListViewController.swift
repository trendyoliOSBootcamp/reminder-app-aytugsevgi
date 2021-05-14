import UIKit

protocol AddNewListPresenterToViewController: AnyObject {
    func configure()
    func setImageViewBackgroundColor(color: UIColor)
    func setImage(name: String)
}

final class AddNewListViewController: UIViewController {
    @IBOutlet weak private var selectedImageBackgroundView: UIView!
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var selectedImageView: UIImageView!
    @IBOutlet weak private var collectionView: UICollectionView!
    var presenter: AddNewListViewControllerToPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @IBAction private func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }
    
    @IBAction private func nameTextFieldChanged() {
        presenter.nameTextFieldChanged(nameTextField.text)
    }
}

extension AddNewListViewController: AddNewListPresenterToViewController {
    func configure() {
        selectedImageBackgroundView.makeCircle()
        collectionView.register(reusableCellType: ColorCollectionViewCell.self)
        collectionView.register(reusableCellType: ImageCollectionViewCell.self)
    }
    
    func setImageViewBackgroundColor(color: UIColor) {
        let tdView = TDView(view: selectedImageBackgroundView,
                            color: color)
        tdView.apply()
    }
    
    func setImage(name: String) {
        selectedImageView.image = UIImage(systemName: name)
    }
}

extension AddNewListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(type: ColorCollectionViewCell.self, for: indexPath)
            let listColor = presenter.colorForItem(at: indexPath.row)
            let viewModel = ColorCollectionViewCellViewModel(backgroundColor: listColor.color)
            cell.configure(viewModel: viewModel)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(type: ImageCollectionViewCell.self, for: indexPath)
        let image = presenter.imageForItem(at: indexPath.item)
        let viewModel = ImageCollectionViewCellViewModel(backgroundColor: UIColor.systemGray6, image: UIImage(systemName: image))
        cell.configure(viewModel: viewModel)
        return cell
    }
}

extension AddNewListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(section: indexPath.section, item: indexPath.item)
    }
}

extension AddNewListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        let size = presenter.sizeForItem(width: Double(collectionView.frame.width), minimumLineSpacing: Double(layout.minimumLineSpacing),
                              sectionInsetLeft: Double(layout.sectionInset.left), sectionInsetRight: Double(layout.sectionInset.right))
        return CGSize(width: size.width, height: size.height)
    }
}
