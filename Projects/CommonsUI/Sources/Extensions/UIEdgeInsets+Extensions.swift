import UIKit

public extension UIEdgeInsets {
    static func horizontal(value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: value, bottom: 0.0, right: value)
    }

    static func vertical(value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: 0.0, bottom: value, right: 0.0)
    }

    static func build(horizontal: CGFloat, vertical: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    static func build(value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
