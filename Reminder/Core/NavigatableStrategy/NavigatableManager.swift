import UIKit

class NavigatableManager {
    static let shared = NavigatableManager()
    private let items: [Navigatable] = [AddNewListNavigatable(), AddNewReminderNavigatable()]
    
    func push(to identifier: StoryboardId, navigationController: UINavigationController?, delegate: AnyObject? = nil) {
        items.first(where: {$0.isSatisfied(identifier: identifier, delegate: delegate)})?.execute(navigationController: navigationController, delegate: delegate)
    }
}
