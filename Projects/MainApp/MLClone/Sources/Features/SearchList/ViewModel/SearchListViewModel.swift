//
//  SearchListViewModel.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import Foundation

protocol SearchListViewModelContract {
    func didLoad()
    func retry()
    func getCountList() -> Int
    func getProductViewModel(at index: Int) -> ProductCellViewModel?
    func didTapProduct(at index: Int)
}

final class SearchListViewModel {
    private let coordinator: SearchListCoordinatorContract

    private weak var controller: SearchListViewControllerContract?

    private let searchText: String

    private var results = [SearchResult]()

    private let repository: SearchListRepositoryContract

    init(text: String,
         coordinator: SearchListCoordinatorContract,
         repository: SearchListRepositoryContract = SearchListRepository()) {
        searchText = text
        self.repository = repository
        self.coordinator = coordinator
    }

    func set(controller: SearchListViewControllerContract) {
        self.controller = controller
    }
}

private extension SearchListViewModel {
    func searchProducts() {
        repository.fetchProducts(text: searchText) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.results = model.results
                self.controller?.reloadData()
            case .failure(let error):
                self.controller?.showError(message: error.localizedDescription)
            }
        }
    }
}

extension SearchListViewModel: SearchListViewModelContract {
    func getProductViewModel(at index: Int) -> ProductCellViewModel? {
        guard let model = results[optional: index] else { return nil }

        return ProductCellViewModel(model: model)
    }

    func didTapProduct(at index: Int) {
        // call coordinator
    }

    func didLoad() {
        searchProducts()
    }

    func retry() {
        searchProducts()
    }

    func getCountList() -> Int {
        return results.count
    }
}
