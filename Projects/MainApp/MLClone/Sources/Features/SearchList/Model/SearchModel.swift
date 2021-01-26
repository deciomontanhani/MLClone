//
//  SearchModel.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation

struct SearchModel: Codable {
    let results: [SearchResult]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([SearchResult].self, forKey: .results) ?? []
    }
}

struct SearchResult: Codable {
    let id: String
    let price: Double?
    let shipping: Bool
    let thumbnail: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case price
        case shipping
        case thumbnail
        case title
    }

    enum ShippingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let shippingValues = try values.nestedContainer(keyedBy: ShippingKeys.self, forKey: .shipping)

        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        shipping = try shippingValues.decodeIfPresent(Bool.self, forKey: .freeShipping) ?? false
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
    }
}
