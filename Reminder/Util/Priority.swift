enum Priority: Int {
    case none = 0
    case normal
    case low
    case medium
    case high
    
    var toString: String {
        switch self {
            case .none:
                return "None"
            case .normal:
                return "Normal"
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
        }
    }
    
    var exclamationMark: String {
        switch self {
            case .none:
                return ""
            case .normal:
                return ""
            case .low:
                return "!"
            case .medium:
                return "!!"
            case .high:
                return "!!!"
        }
    }
}
