//
//  JsonUtil.swift
//  MLCloneTests
//
//  Created by Decio Montanhani on 24/01/21.
//  Copyright © 2020 Decio Montanhani. All rights reserved.
//

import Foundation

final class JsonUtil<T: Decodable> {

    typealias JsonType = T
    let bundle: Bundle = Bundle(for: JsonUtil.self)

    func decode(from file: String?) -> JsonType? {
        guard
            let json = bundle.path(forResource: file, ofType: "json"),
            let jsonData = NSData(contentsOfFile: json) as Data? else { return nil }

        do {
            let decoded = try JSONDecoder().decode(JsonType.self, from: jsonData)
            return decoded
        } catch {
            let tSelf = "\(JsonType.self)"
            fatalError("\(error.localizedDescription) : \(file ?? tSelf)")
        }
    }
}
