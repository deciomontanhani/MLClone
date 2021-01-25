//
//  SearchListRepository.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//

import Foundation
import Alamofake

protocol SearchListRepositoryContract {
    func fetchProducts(text: String, completion: @escaping (Result<SearchModel, NetworkError>) -> Void)
}

final class SearchListRepository: SearchListRepositoryContract {

    func fetchProducts(text: String, completion: @escaping (Result<SearchModel, NetworkError>) -> Void) {
        SearchRequest(searchText: text).execute(completion: completion)
    }
}
