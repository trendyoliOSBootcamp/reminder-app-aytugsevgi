protocol HomePresenterToRouter {
    func showAlert()
    func push(identifier: StoryboardId)
}

protocol HomePresenterToInteractor {
    func fetchReminders()
    func fetchLists()
}

protocol HomeRouterToPresenter {
    
}

protocol HomeViewControllerToPresenter {
    var numberOfRows: Int { get }
    func viewDidLoad()
    func updateSearchResults(text: String?)
    func viewDidLayoutSubviews()
    func addListButtonTapped()
    func newReminderButtonTapped()
}

protocol HomeInteractorToPresenter {
    func listFetched(listModels: [ListModel])
}

protocol HomePresenterToViewController: AnyObject {
    func configure()
    func showSearchResult(text: String)
    func setTableViewHeight()
    func reloadData()
}
