import UIKit

final class HomeSearchResultsViewController: UIViewController {
    private var viewModels = [SearchControllerViewModel]()
    private lazy var tableView: UITableView = {
        UITableView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -40).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(reusableCellType: SearchTableViewCell.self)
        tableView.register(SearchTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "searchHeader")
        tableView.tableHeaderView?.backgroundColor = .red
        tableView.sectionHeaderHeight = CGFloat(40)
    }
    
    func configure(viewModels: [SearchControllerViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
}

extension HomeSearchResultsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels[safe: section]?.reminders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: SearchTableViewCell.self, for: indexPath)
        guard let lastItemId = viewModels[indexPath.section].reminders.last?.id else { return cell }
        let isLast = viewModels[indexPath.section].reminders[indexPath.row].id == lastItemId
        cell.configure(reminder: viewModels[indexPath.section].reminders[indexPath.row], isLast: isLast)
        return cell
    }
}

extension HomeSearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "searchHeader") as! SearchTableViewHeader
        view.configure(text: viewModels[section].listTitle, color: viewModels[section].listColor)
        return view
    }
}
