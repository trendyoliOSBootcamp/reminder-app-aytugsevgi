import UIKit
import CoreData

protocol HomeViewInterface: AnyObject {
    func configure()
    func showSearchResult(reminders: [Reminder])
    func setTableViewHeight()
    func reloadData()
}

final class HomeViewController: UIViewController {
    @IBOutlet weak private var allView: UIView!
    @IBOutlet weak private var flaggedView: UIView!
    @IBOutlet weak private var allImageView: UIView!
    @IBOutlet weak private var flaggedImageView: UIView!
    @IBOutlet weak private var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: HomeSearchResultsViewController())
    var presenter: HomePresenterInterface!
    
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
    @IBAction func addListButtonTapped() {
        presenter.addListButtonTapped()
    }
    @IBAction func newReminderButtonTapped() {
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
    }
    
    func showSearchResult(reminders: [Reminder]) {
        let vc = searchController.searchResultsController as? HomeSearchResultsViewController
        vc?.view.bounds = view.frame
        vc?.configure(reminders: reminders)
        
    }
    
    func setTableViewHeight() {
        let height = tableView.rowHeight * CGFloat(tableView.numberOfRows(inSection: 0)) - CGFloat(HomeConstant.rowSeperatorHeight)
        tableView.frame.size.height = height < 0 ? 0 : height
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        let remainderList = presenter.cellForItemAt(index: indexPath.row)
        cell.selectionStyle = .none
        cell.configure(remainderList: remainderList)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
