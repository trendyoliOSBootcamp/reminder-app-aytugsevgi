import UIKit

protocol AddNewListViewInterface: AnyObject {
    func configure()
    func setImageViewBackgroundColor(color: UIColor?)
    func setImage(name: String?)
    func setTextFieldTextColor(color: UIColor?)
    func setTextFieldText(text: String)
}

final class AddNewListViewController: UIViewController {
    @IBOutlet weak private var selectedImageBackgroundView: UIView!
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var selectedImageView: UIImageView!
    @IBOutlet weak private var collectionView: UICollectionView!
    var presenter: AddNewListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @IBAction private func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }

    @IBAction private func nameTextFieldChanged(_ sender: UITextField) {
        presenter.nameTextFieldChanged(text: sender.text)
    }
    @IBAction private func doneButtonTapped() {
        presenter.doneButtonTapped()
    }
}

extension AddNewListViewController: AddNewListViewInterface {
    func configure() {
        selectedImageBackgroundView.makeCircle
        nameTextField.layer.cornerRadius = CGFloat(AddNewListConstant.textFieldCornerRadius)
        collectionView.register(reusableCellType: ColorCollectionViewCell.self)
        collectionView.register(reusableCellType: ImageCollectionViewCell.self)
    }
    
    func setImageViewBackgroundColor(color: UIColor?) {
        selectedImageBackgroundView.applyThreeDimensionEffect(color: color)
    }
    
    func setTextFieldTextColor(color: UIColor?) {
        nameTextField.textColor = color
    }
    
    func setImage(name: String?) {
        guard let name = name else { return }
        selectedImageView.image = UIImage(systemName: name)
    }
    
    func setTextFieldText(text: String) {
        nameTextField.text = text
    }
}

extension AddNewListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var viewModels = [Any]()
        viewModels.append(ColorCollectionViewCellViewModel(backgroundColor: presenter.colorForItem(at: indexPath.row)?.color))
        viewModels.append(ImageCollectionViewCellViewModel(backgroundColor: UIColor.systemGray6,
                                                           image: UIImage(systemName: presenter.imageForItem(at: indexPath.item) ?? "")))
        return ReusableManager.shared.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath,
                                                                    viewModels: viewModels)!
    }
}

extension AddNewListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath: indexPath)
        if indexPath.section == .zero {
            for cell in collectionView.visibleCells {
                guard let cell = cell as? ColorCollectionViewCell else { continue }
                cell.deselectedDisplay()
            }
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell
            cell?.selectedDisplay()
            return
        }
        for cell in collectionView.visibleCells {
            guard let cell = cell as? ImageCollectionViewCell else { continue }
            cell.deselectedDisplay()
        }
        let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
        cell?.selectedDisplay()
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
