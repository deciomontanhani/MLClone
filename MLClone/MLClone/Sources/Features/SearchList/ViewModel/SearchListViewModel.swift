//
//  SearchListViewModel.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import Foundation

protocol SearchListViewModelContract {
    func didLoad()
}

final class SearchListViewModel {
    private let coordinator: SearchListCoordinatorContract

    private let searchText: String

    init(text: String, coordinator: SearchListCoordinatorContract) {
        searchText = text
        self.coordinator = coordinator
    }
}

extension SearchListViewModel: SearchListViewModelContract {
    func didLoad() {
        print(searchText)
    }
}
