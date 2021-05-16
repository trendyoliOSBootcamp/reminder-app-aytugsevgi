import UIKit

class NavigatableManager {
    static let shared = NavigatableManager()
    private let items: [Navigatable] = [AddNewListNavigatable(), AddNewReminderNavigatable(), ListNavigatable()]
    
    func push(to identifier: StoryboardId, navigationController: UINavigationController?, delegate: AnyObject? = nil, args: Any? = nil) {
        items.first(where: {$0.isSatisfied(identifier: identifier, delegate: delegate, args: args)})?
            .execute(navigationController: navigationController, delegate: delegate, args: args)
    }
}
