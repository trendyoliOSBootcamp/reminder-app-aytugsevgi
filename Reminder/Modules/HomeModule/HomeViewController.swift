import UIKit
import CoreData

protocol HomeViewInterface: AnyObject {
    func configure()
    func showSearchResult(viewModels: [SearchControllerViewModel])
    func reloadData()
    func resetNavigationBar()
    func setAllReminderLabelText()
    func setFlaggedReminderLabelText()
}

final class HomeViewController: UIViewController {
    @IBOutlet weak private var allView: UIView!
    @IBOutlet weak private var flaggedView: UIView!
    @IBOutlet weak private var allImageView: UIView!
    @IBOutlet weak private var flaggedImageView: UIView!
    @IBOutlet weak var allReminderLabel: UILabel!
    @IBOutlet weak var flaggedReminderLabel: UILabel!
    @IBOutlet weak private var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: HomeSearchResultsViewController())
    var presenter: HomePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @objc private func allViewTapped() {
        presenter.allViewTapped()
    }
    
    @objc private func flaggedViewTapped() {
        presenter.flaggedViewTapped()
    }
    
    @IBAction private func addListButtonTapped() {
        presenter.addListButtonTapped()
    }
    
    @IBAction private func newReminderButtonTapped() {
        presenter.newReminderButtonTapped()
    }
}

extension HomeViewController: HomeViewInterface {
    func configure() {
        tableView.register(reusableCellType: MyListTableViewCell.self)
        tableView.layer.cornerRadius = CGFloat(HomeConstant.tableViewCornerRadius)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        allView.layer.cornerRadius = CGFloat(HomeConstant.allViewCornerRadius)
        flaggedView.layer.cornerRadius = CGFloat(HomeConstant.flaggedViewCornerRadius)
        allImageView.layer.cornerRadius = allImageView.frame.height * CGFloat(HomeConstant.allImageViewCornerRadiusMultiply)
        flaggedImageView.layer.cornerRadius = flaggedImageView.frame.height * CGFloat(HomeConstant.flaggedImageViewCornerRadiusMultiply)
        let allViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(allViewTapped))
        allView.addGestureRecognizer(allViewGestureRecognizer)
        let flaggedViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flaggedViewTapped))
        flaggedView.addGestureRecognizer(flaggedViewGestureRecognizer)
        allReminderLabel.text = String(presenter.remindersCount)
        flaggedReminderLabel.text = String(presenter.flaggedRemindersCount)
        let footerView = UIView()
        footerView.backgroundColor = view.backgroundColor
        tableView.tableFooterView = footerView
    }
    
    func showSearchResult(viewModels: [SearchControllerViewModel]) {
        let vc = searchController.searchResultsController as? HomeSearchResultsViewController
        vc?.view.bounds = view.safeAreaLayoutGuide.layoutFrame
        vc?.configure(viewModels: viewModels)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setAllReminderLabelText() {
        allReminderLabel.text = String(presenter.remindersCount)
    }
    
    func setFlaggedReminderLabelText() {
        flaggedReminderLabel.text = String(presenter.flaggedRemindersCount)
    }
    
    func resetNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        presenter.updateSearchResults(text: text)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: MyListTableViewCell.self, for: indexPath)
        let remainderList = presenter.cellForItemAt(index: indexPath.row)
        cell.selectionStyle = .none
        cell.configure(remainderList: remainderList)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}

