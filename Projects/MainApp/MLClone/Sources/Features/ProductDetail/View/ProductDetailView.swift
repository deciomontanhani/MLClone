//
//  ProductDetailView.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import UIKit
import CommonsUI

protocol ProductDetailViewContract: UIView {
    func showLoading()
    func stopLoading()
    func showError(message: String?)
    func setup(with model: ProductPresentationModel)
}

protocol ProductDetailViewDelegate: class {
    func retry()
}

final class ProductDetailView: UIView {
    weak var delegate: ProductDetailViewDelegate?

    private lazy var loadingErrorView: LoadingErrorView = {
        let view = LoadingErrorView()
        view.set(state: .loading)
        view.delegate = self
        return view
    }()

    private lazy var scrollView: ScrollView = {
        let view = ScrollView()
        view.addContentView(view: contentView)
        return view
    }()

    private let contentView: UIView = .empty()

    private let soldQuantity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let productTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let productImageView: UIImageView = .defaultImageView()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let freeShippingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "FRETE GRÁTIS"
        label.textColor = .systemGreen
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViewCode()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

extension ProductDetailView: ViewCode {
    func buildHierarchy() {
        addSubview(loadingErrorView)
        addSubview(scrollView)
        contentView.addSubview(soldQuantity)
        contentView.addSubview(productTitle)
        contentView.addSubview(productImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(freeShippingLabel)
    }

    func buildConstraints() {
        loadingErrorView.edges(to: self)

        scrollView.edges(to: self, excluding: .top)
        scrollView.safeAreaTop(to: self)

        scrollView.setupSideConstraints(item: contentView)
        scrollView.setupTopConstraintFor(firstItem: contentView)
        scrollView.setupBottomConstraintFor(lastItem: contentView)

        soldQuantity.top(to: contentView, offset: MLSpacing.base)
        soldQuantity.left(to: contentView, offset: MLSpacing.base)

        productTitle.topToBottom(of: soldQuantity, offset: MLSpacing.tiny)
        productTitle.left(to: contentView, offset: MLSpacing.base)
        productTitle.right(to: contentView, offset: MLSpacing.base)

        productImageView.topToBottom(of: productTitle, offset: MLSpacing.base)
        productImageView.left(to: contentView)
        productImageView.right(to: contentView)
        productImageView.height(200)

        priceLabel.topToBottom(of: productImageView, offset: MLSpacing.base)
        priceLabel.left(to: contentView, offset: MLSpacing.base)
        priceLabel.right(to: contentView, offset: MLSpacing.base)

        freeShippingLabel.topToBottom(of: priceLabel, offset: MLSpacing.minimal)
        freeShippingLabel.left(to: contentView, offset: MLSpacing.base)
        freeShippingLabel.bottom(to: contentView, offset: MLSpacing.base, relation: .lessThanOrEqual)
    }

    func additionalSetup() {
        backgroundColor = .white
    }
}

extension ProductDetailView: ProductDetailViewContract {
    func setup(with model: ProductPresentationModel) {
        soldQuantity.text = model.soldQuantity
        productTitle.text = model.productTitle
        productImageView.kf.setImage(with: model.imageUrl)
        priceLabel.text = model.price
        freeShippingLabel.isHidden = !model.showFreeShipping
    }

    func showLoading() {
        loadingErrorView.set(state: .loading)
    }

    func stopLoading() {
        loadingErrorView.set(state: .hidden)
    }

    func showError(message: String?) {
        loadingErrorView.set(text: message)
        loadingErrorView.set(state: .error)
    }
}

extension ProductDetailView: LoadingErrorViewProtocol {
    func retry() {
        delegate?.retry()
    }
}
