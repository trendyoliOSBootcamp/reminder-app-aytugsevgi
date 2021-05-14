import UIKit

protocol AddNewListPresenterToViewController: AnyObject {
    func configure()
}

final class AddNewListViewController: UIViewController {
    @IBOutlet weak var selectedImageBackgroundView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: AddNewListViewControllerToPresenter!
    private var initColor = UIColor.systemBlue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let color = initColor.encode(),
              let image = selectedImageView.image?.pngData() else { return }
        let model = ListModel(name: nameTextField.text ?? "",
                              color: color, image: image)
        presenter.viewDidLoad(listModel: model)
    }

    @IBAction func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }
    
    @IBAction func nameTextFieldChanged() {
        presenter.nameTextFieldChanged(nameTextField.text)
    }
}

extension AddNewListViewController: AddNewListPresenterToViewController {
    func configure() {
        selectedImageBackgroundView.makeCircle()
        setImageViewBackgroundColor(colorData: initColor.encode())
    }
    
    func setImageViewBackgroundColor(colorData: Data?) {
        guard let data = colorData,
              let color = UIColor().color(data: data) else { return }
        let tdView = TDView(view: selectedImageBackgroundView,
                            color: color)
        tdView.apply()
    }
}

extension AddNewListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // create custom cell
        return UICollectionViewCell()
    }
}
