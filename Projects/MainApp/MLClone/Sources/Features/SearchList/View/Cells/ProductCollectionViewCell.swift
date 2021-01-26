//
//  ProductCollectionViewCell.swift
//  MLClone
//
//  Created by Decio Montanhani on 25/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import UIKit
import CommonsUI
import Kingfisher

final class ProductCollectionViewCell: UICollectionViewCell {

    private let title: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let productImageView: UIImageView = .defaultImageView()

    private var viewModel: ProductCellViewModel?

    func set(viewModel: ProductCellViewModel) {
        self.viewModel = viewModel
        setupView()
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        buildViewCode()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

private extension ProductCollectionViewCell {
    func setupView() {
        title.text = viewModel?.productName
        productImageView.kf.setImage(with: viewModel?.productThumbnail)
    }
}

extension ProductCollectionViewCell: ViewCode {
    func buildHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(title)
    }

    func buildConstraints() {
        productImageView.top(to: contentView, offset: MLSpacing.small)
        productImageView.left(to: contentView, offset: MLSpacing.small)
        productImageView.width(60)
        productImageView.height(60)
        
        title.leftToRight(of: productImageView, offset: MLSpacing.tiny)
        title.top(to: contentView, offset: MLSpacing.small)
        title.right(to: contentView, offset: MLSpacing.small)
        title.bottom(to: contentView, offset: MLSpacing.small, relation: .greaterThanOrEqual)
    }

    func additionalSetup() {
        backgroundColor = .white
    }
}
