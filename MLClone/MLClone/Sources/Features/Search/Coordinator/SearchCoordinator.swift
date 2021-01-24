//
//  SearchCoordinator.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import UIKit

protocol SearchCoordinatorContract {
    func showSearchList(text: String)
}

final class SearchCoordinator: SearchCoordinatorContract {

    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start(animated: Bool = false) {
        let viewModel = SearchViewModel(coordinator: self)
        let controller = SearchViewController(viewModel: viewModel)
        navigation.pushViewController(controller, animated: animated)
    }

    func showSearchList(text: String) {
//        let coordinator = SearchListCoordinator(navigation: navigation)
//        coordinator.start()
    }
}
