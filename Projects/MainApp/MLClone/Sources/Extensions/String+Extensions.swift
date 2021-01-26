//
//  String+Extensions.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    func parseWhiteSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "\u{A0}")
    }
}

extension Optional where Wrapped == String {
    func `default`() -> String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return ""
        }
    }
}
