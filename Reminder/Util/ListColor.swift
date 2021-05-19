import UIKit

enum ListColor: Int {
    case systemRed = 0
    case systemOrange
    case systemYellow
    case systemGreen
    case systemBlue
    case systemTeal
    case systemGray2
    case systemPink
    case systemPurple
    case systemIndigo
    case brown
    case red
    case darkGray
    
    var color: UIColor {
        switch self {
        case .systemRed:
            return UIColor.systemRed
        case .systemOrange:
            return UIColor.systemOrange
        case .systemYellow:
            return UIColor.systemYellow
        case .systemGreen:
            return UIColor.systemGreen
        case .systemBlue:
            return UIColor.systemBlue
        case .systemTeal:
            return UIColor.systemTeal
        case .systemGray2:
            return UIColor.systemGray2
        case .systemPink:
            return UIColor.systemPink
        case .systemPurple:
            return UIColor.systemPurple
        case .systemIndigo:
            return UIColor.systemIndigo
        case .brown:
            return UIColor.brown
        case .red:
            return UIColor.red
        case .darkGray:
            return UIColor.darkGray
        }
        
    }

}
