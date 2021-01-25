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

    private let repository: SearchListRepositoryContract

    init(text: String,
         coordinator: SearchListCoordinatorContract,
         repository: SearchListRepositoryContract = SearchListRepository()) {
        searchText = text
        self.repository = repository
        self.coordinator = coordinator
    }
}

extension SearchListViewModel: SearchListViewModelContract {
    func didLoad() {
        repository.fetchProducts(text: searchText) { result in
            switch result {
            case .success(let model):
                print("")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
