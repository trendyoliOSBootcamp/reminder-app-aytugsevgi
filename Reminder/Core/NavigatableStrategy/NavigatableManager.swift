import UIKit

class NavigatableManager {
    static let shared = NavigatableManager()
    private let items: [Navigatable] = [AddNewListNavigatable(), AddNewReminderNavigatable()]
    
    func push(to identifier: StoryboardId, using navigationController: UINavigationController?) {
        items.first(where: {$0.isSatisfied(identifier: identifier)})?.execute(navigationController: navigationController)
    }
}
