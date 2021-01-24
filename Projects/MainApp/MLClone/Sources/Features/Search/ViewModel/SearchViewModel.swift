//
//  SearchViewModel.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import Foundation

protocol SearchViewModelContract {
    func didTapSearch(text: String)
}

final class SearchViewModel: SearchViewModelContract {

    private let coordinator: SearchCoordinatorContract

    init(coordinator: SearchCoordinatorContract) {
        self.coordinator = coordinator
    }

    func didTapSearch(text: String) {
        guard !text.isEmpty else { return }

        coordinator.showSearchList(text: text)
    }
}
