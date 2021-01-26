//
//  UIView+Extensions.swift
//  CommonsUI
//
//  Created by Decio Montanhani on 26/01/21.
//

import UIKit

public extension UIView {
    static func empty(height: CGFloat? = nil, width: CGFloat? = nil) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        if let height = height { view.height(height) }
        if let width = width { view.width(width) }
        return view
    }

    static func fat() -> UIView {
        let view = UIView.empty()

        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .vertical)

        return view
    }

    static func light() -> UIView {
        let view = UIView.empty()

        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .vertical)

        return view
    }

    func wrap(inset: Bool = false) -> UIView {
        let view = UIView.empty()
        view.addSubview(self)

        if inset {
            view.edges(to: self)
        }

        return view
    }

    func safeInsetConstraints(inSuperview superView: UIView, withInset inset: UIEdgeInsets? = nil) {
        self.safeAreaTop(to: superView, offset: -(inset?.top ?? 0.0))
        self.left(to: superView, offset: -(inset?.left ?? 0.0))
        self.right(to: superView, offset: (inset?.right ?? 0.0))
        self.bottom(to: superView, offset: (inset?.bottom ?? 0.0))
    }
}
