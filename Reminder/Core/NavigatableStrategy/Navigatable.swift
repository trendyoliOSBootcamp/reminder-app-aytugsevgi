import UIKit

protocol Navigatable {
    func isSatisfied(identifier: StoryboardId, delegate: AnyObject?, args: Any?) -> Bool
    func execute(navigationController: UINavigationController?, delegate: AnyObject?, args: Any?)
}
