import UIKit

protocol HomePresenterToViewController: AnyObject {
    func configure()
    func showSearchResult(text: String)
    func setTableViewHeight()
}

final class HomeViewController: UIViewController {
    @IBOutlet weak private var allView: UIView!
    @IBOutlet weak private var flaggedView: UIView!
    @IBOutlet weak private var allImageView: UIView!
    @IBOutlet weak private var flaggedImageView: UIView!
    @IBOutlet weak private var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: HomeSearchResultsViewController())
    var presenter: HomeViewControllerToPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.viewDidLayoutSubviews()
    }
    
    @objc private func allViewTapped() {
        print(#function)
    }
    
    @objc private func flaggedViewTapped() {
        print(#function)
    }
}

extension HomeViewController: HomePresenterToViewController {
    func configure() {
        tableView.register(reusableCellType: MyListTableViewCell.self)
        tableView.layer.cornerRadius = 8
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        allView.layer.cornerRadius = 8
        flaggedView.layer.cornerRadius = 8
        allImageView.layer.cornerRadius = allImageView.frame.height / 2
        flaggedImageView.layer.cornerRadius = flaggedImageView.frame.height / 2
        let allViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(allViewTapped))
        allView.addGestureRecognizer(allViewGestureRecognizer)
        let flaggedViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flaggedViewTapped))
        flaggedView.addGestureRecognizer(flaggedViewGestureRecognizer)
    }
    
    func showSearchResult(text: String) {
        let vc = searchController.searchResultsController as? HomeSearchResultsViewController
        vc?.view.bounds = view.frame
        vc?.view.backgroundColor = .darkGray
    }
    
    func setTableViewHeight() {
        let oldFrame = self.tableView.frame
        tableView.frame.size.height = tableView.rowHeight * CGFloat(tableView.numberOfRows(inSection: 0)) - CGFloat(Constant.rowSeperatorHeight)
        if oldFrame.height > tableView.frame.height {
            tableView.isScrollEnabled = false
        }
    }
    
    
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.updateSearchResults(text: searchController.searchBar.text)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: MyListTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.configure()
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
