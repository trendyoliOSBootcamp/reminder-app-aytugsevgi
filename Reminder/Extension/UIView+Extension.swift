import UIKit

extension UIView {
    var makeCircle: Void { layer.cornerRadius = frame.height / 2 }
}

extension UIView {
    func applyThreeDimensionEffect(color: UIColor){
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.3
        let offset = CGSize(width: 0, height: 4)
        layer.shadowOffset = offset
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color.withAlphaComponent(0.5).cgColor, color.cgColor]
        gradientLayer.locations = [0,1]
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        guard let subLayers = layer.sublayers else { return }
        if subLayers.count > 1 {
            layer.sublayers?[0].removeFromSuperlayer()
        }
        layer.insertSublayer(gradientLayer, at: 0)
        setNeedsDisplay()
    }
}
