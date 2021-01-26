//
//  SearchListCoordinator.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

protocol SearchListCoordinatorContract {}

final class SearchListCoordinator: SearchListCoordinatorContract {

    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start(searchText: String) {
        let viewModel = SearchListViewModel(text: searchText, coordinator: self)
        let controller = SearchListViewController(viewModel: viewModel)
        viewModel.set(controller: controller)
        navigation.pushViewController(controller, animated: true)
    }
}
