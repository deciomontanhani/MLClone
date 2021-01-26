//
//  ProductDetailRequest.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation

import Foundation
import Alamofake

struct ProductDetailRequest: NetworkSession {

    let productId: String

    init(productId: String) {
        self.productId = productId
    }

    var path: String {
        return "items"
    }

    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "ids", value: productId)]
    }
}
