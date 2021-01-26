//
//  ProductDetailViewModel.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation
import Alamofake

protocol ProductDetailViewModelContract {
    func didLoad()
    func retry()
}

final class ProductDetailViewModel {
    private let coordinator: ProductDetailCoordinatorContract

    private weak var controller: ProductDetailViewControllerContract?

    private let productId: String

    private var results = [SearchResult]()

    private let repository: ProductDetailRepositoryContract

    init(productId: String,
         coordinator: ProductDetailCoordinatorContract,
         repository: ProductDetailRepositoryContract = ProductDetailRepository()) {
        self.productId = productId
        self.repository = repository
        self.coordinator = coordinator
    }

    func set(controller: ProductDetailViewControllerContract) {
        self.controller = controller
    }
}

private extension ProductDetailViewModel {
    func fetchDetail() {
        controller?.showLoading()

        repository.fetchDetail(productId: productId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let model = response.first?.body else {
                    self?.controller?.showError(message: NetworkError.default.localizedDescription)
                    return
                }

                self?.controller?.setup(with: ProductPresentationModel(model: model))
                self?.controller?.stopLoading()
            case .failure(let error):
                self?.controller?.showError(message: error.localizedDescription)
            }
        }
    }
}

extension ProductDetailViewModel: ProductDetailViewModelContract {
    func didLoad() {
        fetchDetail()
    }

    func retry() {
        fetchDetail()
    }
}
