//
//  NumberFormatter+Extensions.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static func create() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")

        return formatter
    }

    static let shared: NumberFormatter = {
        let formatter = NumberFormatter.create()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter
    }()
}
