import UIKit

public enum ViewEdge {
    case none
    case top
    case left
    case bottom
    case right
}

public extension UIView {

    @discardableResult
    func center(in view: UIView, offset: CGPoint = .zero, isActive: Bool = true) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            centerX(to: view, offset: offset.x, isActive: isActive),
            centerY(to: view, offset: offset.y, isActive: isActive)
        ]

        return constraints
    }

    @discardableResult
    func edges(to view: UIView, excluding excludedEdge: ViewEdge = .none, insets: UIEdgeInsets = .zero, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()

        if excludedEdge != .top {
            constraints.append(top(to: view, offset: insets.top, relation: relation, isActive: isActive))
        }

        if excludedEdge != .left {
            constraints.append(left(to: view, offset: insets.left, relation: relation, isActive: isActive))
        }

        if excludedEdge != .bottom {
            constraints.append(bottom(to: view, offset: -insets.bottom, relation: relation, isActive: isActive))
        }

        if excludedEdge != .right {
            constraints.append(right(to: view, offset: -insets.right, relation: relation, isActive: isActive))
        }

        return constraints
    }

    @discardableResult
    func size(_ size: CGSize, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            width(size.width, relation: relation, isActive: isActive),
            height(size.height, relation: relation, isActive: isActive)
        ]

        return constraints
    }

    @discardableResult
    func size(to view: UIView, multiplier: CGFloat = 1, insets: CGSize = .zero, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            width(to: view, multiplier: multiplier, offset: insets.width, relation: relation, isActive: isActive),
            height(to: view, multiplier: multiplier, offset: insets.height, relation: relation, isActive: isActive)
        ]

        return constraints
    }

    @discardableResult
    func origin(to view: UIView, insets: UIEdgeInsets = .zero, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            left(to: view, offset: insets.left, relation: relation, isActive: isActive),
            top(to: view, offset: insets.top, relation: relation, isActive: isActive)
        ]

        return constraints
    }

    @discardableResult
    func width(_ width: CGFloat, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal: return widthAnchor.constraint(equalToConstant: width).set(isActive)
        case .lessThanOrEqual: return widthAnchor.constraint(lessThanOrEqualToConstant: width).set(isActive)
        case .greaterThanOrEqual: return widthAnchor.constraint(greaterThanOrEqualToConstant: width).set(isActive)
        default:
            return widthAnchor.constraint(equalToConstant: width).set(isActive)
        }
    }

    @discardableResult
    func width(to view: UIView, _ dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return widthAnchor.constraint(equalTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).set(isActive)
        case .lessThanOrEqual:
            return widthAnchor.constraint(lessThanOrEqualTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).set(isActive)
        case .greaterThanOrEqual:
            return widthAnchor.constraint(greaterThanOrEqualTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).set(isActive)
        default:
            return widthAnchor.constraint(equalTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).set(isActive)
        }
    }

    @discardableResult
    func widthToHeight(of view: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        return width(to: view, view.heightAnchor, multiplier: multiplier, offset: offset, relation: relation, isActive: isActive)
    }

    @discardableResult
    func width(min: CGFloat? = nil, max: CGFloat? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []

        if let min = min {
            let constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: min)
            constraint.isActive = isActive
            constraints.append(constraint)
        }

        if let max = max {
            let constraint = widthAnchor.constraint(lessThanOrEqualToConstant: max)
            constraint.isActive = isActive
            constraints.append(constraint)
        }

        return constraints
    }

    @discardableResult
    func height(_ height: CGFloat, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return heightAnchor.constraint(equalToConstant: height).set(isActive)
        case .lessThanOrEqual:
            return heightAnchor.constraint(lessThanOrEqualToConstant: height).set(isActive)
        case .greaterThanOrEqual:
            return heightAnchor.constraint(greaterThanOrEqualToConstant: height).set(isActive)
        default:
            return heightAnchor.constraint(equalToConstant: height).set(isActive)
        }
    }

    @discardableResult
    func height(to view: UIView, _ dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return heightAnchor.constraint(equalTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).set(isActive)
        case .lessThanOrEqual:
            return heightAnchor.constraint(lessThanOrEqualTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).set(isActive)
        case .greaterThanOrEqual:
            return heightAnchor.constraint(greaterThanOrEqualTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).set(isActive)
        default:
            return heightAnchor.constraint(equalTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).set(isActive)
        }
    }

    @discardableResult
    func heightToWidth(of view: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        return height(to: view, view.widthAnchor, multiplier: multiplier, offset: offset, relation: relation, isActive: isActive)
    }

    @discardableResult
    func height(min: CGFloat? = nil, max: CGFloat? = nil, isActive: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []

        if let min = min {
            let constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: min)
            constraint.isActive = isActive
            constraints.append(constraint)
        }

        if let max = max {
            let constraint = heightAnchor.constraint(lessThanOrEqualToConstant: max)
            constraint.isActive = isActive
            constraints.append(constraint)
        }

        return constraints
    }

    @discardableResult
    func aspectRatio(_ ratio: CGFloat, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        return widthToHeight(of: self, multiplier: ratio, offset: 0, relation: relation, isActive: isActive)
    }

    @discardableResult
    func leadingToTrailing(of view: UIView, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return leading(to: view, view.trailingAnchor, offset: offset, relation: relation, isActive: isActive)
    }

    @discardableResult
    func leading(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return leadingAnchor.constraint(equalTo: anchor ?? view.leadingAnchor, constant: offset).set(isActive)
        case .lessThanOrEqual:
            return leadingAnchor.constraint(lessThanOrEqualTo: anchor ?? view.leadingAnchor, constant: offset).set(isActive)
        case .greaterThanOrEqual:
            return leadingAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.leadingAnchor, constant: offset).set(isActive)
        default:
            return leadingAnchor.constraint(equalTo: anchor ?? view.leadingAnchor, constant: offset).set(isActive)
        }
    }

    @discardableResult
    func horizontal(of view: UIView, offset: CGFloat = 0, isActive: Bool = true) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            left(to: view, offset: offset, isActive: isActive),
            right(to: view, offset: offset, isActive: isActive)
        ]

        return constraints
    }

    @discardableResult
    func leftToRight(of view: UIView, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return left(to: view, view.rightAnchor, offset: offset, relation: relation, isActive: isActive)
    }

    @discardableResult
    func left(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return leftAnchor.constraint(equalTo: anchor ?? view.leftAnchor, constant: offset).set(isActive)
        case .lessThanOrEqual:
            return leftAnchor.constraint(lessThanOrEqualTo: anchor ?? view.leftAnchor, constant: offset).set(isActive)
        case .greaterThanOrEqual:
            return leftAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.leftAnchor, constant: offset).set(isActive)
        default:
            return leftAnchor.constraint(equalTo: anchor ?? view.leftAnchor, constant: offset).set(isActive)
        }
    }

    @discardableResult
    func trailingToLeading(of view: UIView, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return trailing(to: view, view.leadingAnchor, offset: offset, relation: relation, isActive: isActive)
    }

    @discardableResult
    func trailing(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return trailingAnchor.constraint(equalTo: anchor ?? view.trailingAnchor, constant: offset).set(isActive)
        case .lessThanOrEqual:
            return trailingAnchor.constraint(lessThanOrEqualTo: anchor ?? view.trailingAnchor, constant: offset).set(isActive)
        case .greaterThanOrEqual:
            return trailingAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.trailingAnchor, constant: offset).set(isActive)
        default:
            return trailingAnchor.constraint(equalTo: anchor ?? view.trailingAnchor, constant: offset).set(isActive)
        }
    }

    @discardableResult
    func rightToLeft(of view: UIView, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return right(to: view, view.leftAnchor, offset: offset, relation: relation, isActive: isActive)
    }

    @discardableResult
    func right(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return rightAnchor.constraint(equalTo: anchor ?? view.rightAnchor, constant: (offset * -1)).set(isActive)
        case .lessThanOrEqual:
            return rightAnchor.constraint(lessThanOrEqualTo: anchor ?? view.rightAnchor, constant: (offset * -1)).set(isActive)
        case .greaterThanOrEqual:
            return rightAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.rightAnchor, constant: (offset * -1)).set(isActive)
        default:
            return rightAnchor.constraint(equalTo: anchor ?? view.rightAnchor, constant: (offset * -1)).set(isActive)
        }
    }

    @discardableResult
    func topToBottom(of view: UIView, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return top(to: view, view.bottomAnchor, offset: offset, relation: relation, isActive: isActive)
    }

    @discardableResult
    func safeAreaTop(to view: UIView, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor,
                constant: offset).set(isActive)
        case .lessThanOrEqual:
            return topAnchor.constraint(lessThanOrEqualTo: anchor ?? view.topAnchor, constant: offset).set(isActive)
        case .greaterThanOrEqual:
            return topAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.topAnchor, constant: offset).set(isActive)
        default:
            return topAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: offset).set(isActive)
        }
    }

    @discardableResult
    func top(to view: UIView, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return topAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: offset).set(isActive)
        case .lessThanOrEqual:
            return topAnchor.constraint(lessThanOrEqualTo: anchor ?? view.topAnchor, constant: offset).set(isActive)
        case .greaterThanOrEqual:
            return topAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.topAnchor, constant: offset).set(isActive)
        default:
            return topAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: offset).set(isActive)
        }
    }

    @discardableResult
    func bottomToTop(of view: UIView, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return bottom(to: view, view.topAnchor, offset: offset, relation: relation, isActive: isActive)
    }

    @discardableResult
    func bottom(to view: UIView, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        switch relation {
        case .equal:
            return bottomAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: (offset * -1)).set(isActive)
        case .lessThanOrEqual:
            return bottomAnchor.constraint(lessThanOrEqualTo: anchor ?? view.bottomAnchor, constant: (offset * -1)).set(isActive)
        case .greaterThanOrEqual:
            return bottomAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.bottomAnchor, constant: (offset * -1)).set(isActive)
        default:
            return bottomAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: (offset * -1)).set(isActive)
        }
    }

    @discardableResult
    func centerX(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint: NSLayoutConstraint

        if let anchor = anchor {
            constraint = centerXAnchor.constraint(equalTo: anchor, constant: offset)
        } else {
            constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: multiplier, constant: offset)
        }

        constraint.isActive = isActive
        return constraint
    }

    @discardableResult
    func centerY(to view: UIView, _ anchor: NSLayoutYAxisAnchor? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint: NSLayoutConstraint

        if let anchor = anchor {
            constraint = centerYAnchor.constraint(equalTo: anchor, constant: offset)
        } else {
            constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: multiplier, constant: offset)
        }

        constraint.isActive = isActive
        return constraint
    }
}

public extension NSLayoutConstraint {
    func set(_ active: Bool) -> Self {
        isActive = active
        return self
    }
}
