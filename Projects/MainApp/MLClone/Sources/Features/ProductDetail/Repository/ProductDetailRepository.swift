//
//  ProductDetailRepository.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation
import Alamofake

protocol ProductDetailRepositoryContract {
    func fetchDetail(productId: String, completion: @escaping (Result<[ProductDetailModel], NetworkError>) -> Void)
}

final class ProductDetailRepository: ProductDetailRepositoryContract {

    func fetchDetail(productId: String, completion: @escaping (Result<[ProductDetailModel], NetworkError>) -> Void) {
        ProductDetailRequest(productId: productId).execute(completion: completion)
    }
}
