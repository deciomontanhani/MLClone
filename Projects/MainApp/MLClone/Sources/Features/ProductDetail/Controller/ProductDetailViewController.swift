//
//  ProductDetailViewController.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import UIKit

protocol ProductDetailViewControllerContract: class {
    func showLoading()
    func stopLoading()
    func showError(message: String?)
    func setup(with model: ProductPresentationModel)
}

final class ProductDetailViewController: UIViewController {

    private lazy var customView: ProductDetailViewContract = {
        let view = ProductDetailView()
        view.delegate = self
        return view
    }()

    private let viewModel: ProductDetailViewModelContract

    init(viewModel: ProductDetailViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didLoad()
        title = "Detalhes do Produto"
    }

    override func loadView() {
        super.loadView()
        view = customView
    }
}

extension ProductDetailViewController: ProductDetailViewControllerContract {
    func showLoading() {
        customView.showLoading()
    }

    func stopLoading() {
        customView.stopLoading()
    }

    func showError(message: String?) {
        customView.showError(message: message)
    }

    func setup(with model: ProductPresentationModel) {
        customView.setup(with: model)
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func retry() {
        viewModel.retry()
    }
}
