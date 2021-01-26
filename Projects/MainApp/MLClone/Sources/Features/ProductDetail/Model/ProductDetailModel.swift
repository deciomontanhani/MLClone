//
//  ProductDetailModel.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation

struct ProductDetailModel: Codable {
    let body: ProductDetail
}

struct ProductDetail: Codable {
    let id: String
    let title: String
    let price: Double?
    let soldQuantity: Int
    let freeShipping: Bool
    let pictures: [ProductDetailPicture]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case pictures
        case freeShipping = "shipping"
        case soldQuantity = "sold_quantity"
    }

    enum ShippingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let shippingValues = try values.nestedContainer(keyedBy: ShippingKeys.self, forKey: .freeShipping)

        freeShipping = try shippingValues.decodeIfPresent(Bool.self, forKey: .freeShipping) ?? false
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        pictures = try values.decodeIfPresent([ProductDetailPicture].self, forKey: .pictures) ?? []
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        soldQuantity = try values.decodeIfPresent(Int.self, forKey: .soldQuantity) ?? 0
    }
}

struct ProductDetailPicture: Codable {
    let id: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case url = "secure_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}
