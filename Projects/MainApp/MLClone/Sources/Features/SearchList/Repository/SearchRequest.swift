//
//  SearchRequest.swift
//  MLClone
//
//  Created by Decio Montanhani on 24/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation
import Alamofake

struct SearchRequest: NetworkSession {

    let searchText: String

    init(searchText: String) {
        self.searchText = searchText
    }

    var path: String {
        return "sites/MLB/search"
    }

    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "q", value: searchText)]
    }
}
