//
//  ScrollView.swift
//  CommonsUI
//
//  Created by Decio Montanhani on 25/01/21.
//

import UIKit

/// Use this component to create a UIScrollView with a content view already setted and configured.
public class ScrollView: UIView {
    public let innerScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()

    public let innerContentView = UIView()

    public init() {
        super.init(frame: .zero)
        buildViewCode()
    }

    required public init?(coder: NSCoder) { return nil }

    /// The UIScrollView frame height
    public var height: CGFloat {
        return innerScrollView.frame.height
    }

    /// Adds a view to the scroll content view
    public func addContentView(view: UIView) {
        innerContentView.addSubview(view)
    }

    /// Sets the constraint for the **first** element of the scroll view.
    public func setupTopConstraintFor(firstItem: UIView,
                               topConstant: CGFloat = 0.0,
                               relatedBy relation: NSLayoutConstraint.Relation = .equal) {
        firstItem.top(to: innerContentView, offset: topConstant, relation: relation)
    }

    /// Sets the side constraints for the element of the scroll view.
    public func setupSideConstraints(item: UIView,
                              leftConstant: CGFloat = 0.0,
                              rightConstant: CGFloat = 0.0,
                              leftRelation: NSLayoutConstraint.Relation = .equal,
                              rightRelation: NSLayoutConstraint.Relation = .equal) {
        item.left(to: innerContentView, offset: leftConstant, relation: leftRelation)
        item.right(to: innerContentView, offset: rightConstant, relation: rightRelation)
    }

    /// Sets the constraint for the **last** element of the scroll view.
    public func setupBottomConstraintFor(lastItem: UIView,
                                  bottomConstant: CGFloat = 0.0,
                                  relatedBy relation: NSLayoutConstraint.Relation = .lessThanOrEqual) {
        lastItem.bottom(to: innerContentView, offset: bottomConstant, relation: relation)
    }

    /// Scrolls to an specific point of the scroll content view. It could be animated or not.
    public func scrollTo(point: CGPoint, animated: Bool = true) {
        let contentOffset = innerContentView.convert(point, from: innerScrollView)
        innerScrollView.setContentOffset(contentOffset, animated: animated)
    }

    /// Sets up base contraints for this view
    public func setupBaseConstraints(under topView: UIView, horizontalAndBottom bodyView: UIView) {
        topToBottom(of: topView)
        horizontal(of: bodyView)
        bottom(to: bodyView)
    }
}

extension ScrollView: ViewCode {
    public func buildHierarchy() {
        addSubview(innerScrollView)
        innerScrollView.addSubview(innerContentView)
    }

    public func buildConstraints() {
        innerScrollView.top(to: self)
        innerScrollView.left(to: self)
        innerScrollView.right(to: self)
        innerScrollView.bottom(to: self)

        innerContentView.top(to: innerScrollView)
        innerContentView.height(to: innerScrollView, relation: .greaterThanOrEqual)
        innerContentView.width(to: innerScrollView)
        innerContentView.centerX(to: innerScrollView)

        innerContentView.bottom(to: innerScrollView)
    }

    public func additionalSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        innerScrollView.translatesAutoresizingMaskIntoConstraints = false
        innerContentView.translatesAutoresizingMaskIntoConstraints = false
    }
}
