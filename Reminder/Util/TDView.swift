import UIKit

final class TDView: UIView, ThreeDimensionEffectable {
    let color: UIColor
    let view: UIView
    
    init(view: UIView, color: UIColor) {
        self.color = color
        self.view = view
        super.init(frame: view.frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
