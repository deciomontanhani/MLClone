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
        view.font = .systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let price: UILabel = {
        let view = UILabel()
        view.textColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let freeShipping: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.backgroundColor = .systemGreen
        view.textColor = .white
        view.text = "FRETE GRÁTIS"

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
        guard let viewModel = viewModel else { return }
        title.text = viewModel.productName
        productImageView.kf.setImage(with: viewModel.productThumbnail)
        price.text = viewModel.price
        freeShipping.isHidden = !viewModel.freeShipping
    }
}

extension ProductCollectionViewCell: ViewCode {
    func buildHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(title)
        contentView.addSubview(price)
        contentView.addSubview(freeShipping)
    }

    func buildConstraints() {
        productImageView.top(to: contentView, offset: MLSpacing.small)
        productImageView.left(to: contentView, offset: MLSpacing.small)
        productImageView.width(100)
        productImageView.bottom(to: contentView, offset: MLSpacing.small)
        
        title.leftToRight(of: productImageView, offset: MLSpacing.tiny)
        title.top(to: contentView, offset: MLSpacing.small)
        title.right(to: contentView, offset: MLSpacing.small)

        price.topToBottom(of: title, offset: MLSpacing.tiny)
        price.leftToRight(of: productImageView, offset: MLSpacing.tiny)
        price.right(to: contentView, offset: MLSpacing.small)

        freeShipping.topToBottom(of: price, offset: MLSpacing.tiny)
        freeShipping.leftToRight(of: productImageView, offset: MLSpacing.tiny)
    }

    func additionalSetup() {
        backgroundColor = .white
    }
}
