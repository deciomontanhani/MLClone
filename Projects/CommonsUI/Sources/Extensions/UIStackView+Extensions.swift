//
//  UIStackView+Extensions.swift
//  CommonsUI
//
//  Created by Decio Montanhani on 25/01/21.
//

import UIKit

public extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })
        removedSubviews.forEach { $0.removeFromSuperview() }
    }

    static func defaultStackView(arrangeSubview: [UIView] = [],
                                 axis: NSLayoutConstraint.Axis = .vertical,
                                 distribution: UIStackView.Distribution = .fill,
                                 alignment: UIStackView.Alignment = .fill,
                                 spacing: CGFloat = 0,
                                 layoutMargins: UIEdgeInsets = .zero) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangeSubview)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.layoutMargins = layoutMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = distribution
        stackView.alignment = alignment
        return stackView
    }
}
