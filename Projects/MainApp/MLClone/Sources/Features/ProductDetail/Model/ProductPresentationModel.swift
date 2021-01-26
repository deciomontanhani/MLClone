//
//  ProductPresentationModel.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation

struct ProductPresentationModel {
    let soldQuantity: String
    let productTitle: String
    let imageUrl: URL?
    let price: String
    let showFreeShipping: Bool

    init(model: ProductDetail) {
        soldQuantity = model.soldQuantity > 0 ? "\(model.soldQuantity) vendidos" : ""
        productTitle = model.title
        let url = model.pictures.first?.url ?? ""
        imageUrl = URL(string: url)
        price = model.price?.toCurrency ?? ""
        showFreeShipping = model.freeShipping
    }
}
