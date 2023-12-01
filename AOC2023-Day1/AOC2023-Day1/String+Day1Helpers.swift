//
//  String+Day1Helpers.swift
//  AOC2023-Day1
//
//  Created by LennartWisbar on 01.12.23.
//

import Foundation

public extension String {
    var firstDigit: String? {
        guard let digit = first(where: { $0.isNumber }) else {
            return nil
        }
        return String(digit)
    }

    var lastDigit: String? {
        guard let digit = String(reversed()).firstDigit else {
            return nil
        }
        return String(digit)
    }

    var calibrationValue: Int? {
        guard let firstDigit, let lastDigit else {
            return nil
        }
        return Int(firstDigit + lastDigit)
    }

    var calibrationSum: Int? {
        components(separatedBy: .newlines)
            .compactMap { $0.calibrationValue }
            .reduce(0, +)
    }
}
