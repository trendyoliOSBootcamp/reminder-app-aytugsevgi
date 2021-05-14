import UIKit

protocol ThreeDimensionEffectable {
    var color: UIColor { get }
    var view: UIView { get }
    
    func apply()
}

extension ThreeDimensionEffectable {
    func apply() {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.3
        let offset = CGSize(width: 0, height: 4)
        view.layer.shadowOffset = offset
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color.withAlphaComponent(0.5).cgColor, color.cgColor]
        gradientLayer.locations = [0,1]
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = view.layer.cornerRadius
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
