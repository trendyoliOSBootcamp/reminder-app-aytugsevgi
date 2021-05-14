import UIKit

extension UIView {
    func makeCircle() {
        let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
    }
}
