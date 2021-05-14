import UIKit

class NavigationBuilder {
    
    static func build() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.view.backgroundColor = .systemGray6
        return navigationController
    }
}
