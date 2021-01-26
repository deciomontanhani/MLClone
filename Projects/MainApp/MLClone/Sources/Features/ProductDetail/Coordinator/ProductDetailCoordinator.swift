//
//  ProductDetailCoordinator.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import UIKit

protocol ProductDetailCoordinatorContract {}

final class ProductDetailCoordinator: ProductDetailCoordinatorContract {

    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start(productId: String) {
        let viewModel = ProductDetailViewModel(productId: productId, coordinator: self)
        let controller = ProductDetailViewController(viewModel: viewModel)
        viewModel.set(controller: controller)
        navigation.pushViewController(controller, animated: true)
    }
}
