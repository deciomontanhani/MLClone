//
//  Double+Extensions.swift
//  MLClone
//
//  Created by Decio Montanhani on 26/01/21.
//  Copyright © 2021 Décio Montanhani. All rights reserved.
//

import Foundation

public extension Double {
    var positive: Bool {
        return self > 0
    }

    var negative: Bool {
        return self < 0
    }

    var positiveOrZero: Bool {
        return self.positive || self == .zero
    }

    var signal: String {
        var signal = ""

        if positive { signal = "+" }
        if negative { signal = "-" }

        return signal
    }

    var minify: String {
        let abbrev = "KMB"

        let result = abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
            let factor = Double(abs(self).rounded()) / pow(10, Double(tuple.0 + 1) * 3)
            let format = (factor.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f%@" : "%.1f%@")
            return accum ?? (factor >= 1 ? String(format: format, factor, String(tuple.1)) : nil)
            } ?? String(Int(abs(self)))

        return result
    }
}

public extension Double {
    var toCurrency: String {
        return self.toCurrency()
    }

    var toCurrencySigned: String {
        return self.toCurrency(signed: true)
    }

    func toCurrency(fraction min: Int? = nil, max: Int? = nil, signed: Bool = false) -> String {
        let formatter = NumberFormatter.create()
        formatter.numberStyle = .currency

        if let min = min {
            formatter.minimumFractionDigits = min
        }

        if let max = max {
            formatter.maximumFractionDigits = max
        }

        if signed {
            let number = NSNumber(value: abs(self))
            let value = formatter.string(from: number).default()

            return "\(signal) \(value)".trim()
        }

        return formatter.string(from: NSNumber(value: self)).default()
    }
}

public extension Double {
    var toPercent: String {
        return toPercent(fraction: 2, max: 2)
    }

    var toPercentSigned: String {
        return toPercent(fraction: 2, max: 2, signed: true)
    }

    func toPercent(fraction min: Int? = nil, max: Int? = nil, signed: Bool = false) -> String {
        let formatter = NumberFormatter.create()
        formatter.numberStyle = .percent
        formatter.multiplier = 1.0

        if let min = min {
            formatter.minimumFractionDigits = min
        }

        if let max = max {
            formatter.maximumFractionDigits = max
        }

        if signed {
            let number = NSNumber(value: abs(self))
            let value = formatter.string(from: number).default()

            return "\(signal) \(value)".trim()
        }

        return formatter.string(from: NSNumber(value: self)).default()
    }
}

public extension Double {
    var toDecimal: String {
        return toDecimal()
    }

    var toDecimalSigned: String {
        return toDecimal(signed: true)
    }

    func toDecimal(fraction min: Int? = nil, max: Int? = nil, signed: Bool = false) -> String {
        let formatter = NumberFormatter.create()
        formatter.numberStyle = .decimal

        if let min = min {
            formatter.minimumFractionDigits = min
        }

        if let max = max {
            formatter.maximumFractionDigits = max
        }

        if signed {
            let number = NSNumber(value: abs(self))
            let value = formatter.string(from: number).default()

            return "\(signal) \(value)".trim()
        }

        return formatter.string(from: NSNumber(value: self)).default()
    }
}

public extension Double {
    var toDefaultFormat: String {
        let numberFormatter = NumberFormatter.shared
        numberFormatter.numberStyle = .decimal

        return numberFormatter.string(from: NSNumber(value: self)).default()
    }

    var toDefaultFormatSigned: String {
        let value = abs(self)
        return "\(signal) \(value.toDefaultFormat)".trim()
    }
}
