import UIKit

protocol Navigatable {
    func isSatisfied(identifier: StoryboardId, delegate: AnyObject?) -> Bool
    func execute(navigationController: UINavigationController?, delegate: AnyObject?)
}
