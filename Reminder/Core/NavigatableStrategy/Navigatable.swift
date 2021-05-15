import UIKit

protocol Navigatable {
    func isSatisfied(identifier: StoryboardId) -> Bool
    func execute(navigationController: UINavigationController?)
}
