//
//  String+Day1Helpers.swift
//  AOC2023-Day1
//
//  Created by LennartWisbar on 01.12.23.
//

import Foundation

public enum Day1 {
    public enum Part1 {
        public static func calibrationSum(in input: String) -> Int? {
            input
                .components(separatedBy: .newlines)
                .compactMap { calibrationValue(in: $0) }
                .reduce(0, +)
        }

        static func calibrationValue(in input: String) -> Int? {
            guard let firstDigit = firstDigit(in: input), let lastDigit = lastDigit(in: input) else {
                return nil
            }
            return Int(firstDigit + lastDigit)
        }

        static func firstDigit(in input: String) -> String? {
            guard let digit = input.first(where: { $0.isNumber }) else {
                return nil
            }
            return String(digit)
        }

        static func lastDigit(in input: String) -> String? {
            guard let digit = firstDigit(in: String(input.reversed())) else {
                return nil
            }
            return String(digit)
        }
    }

    public enum Part2 {
        static func calibrationValue(in input: String) -> Int? {
            guard let firstDigit = firstDigit(in: input), let lastDigit = lastDigit(in: input) else {
                return nil
            }
            return Int(firstDigit + lastDigit)
        }

        static func firstDigit(in input: String) -> String? {
            let foundNumbers = input.ranges(of: digitPattern)
            guard let firstIndex = foundNumbers.first else { return nil }
            let firstMatch = input[firstIndex]
            if let numericDigit = Int(firstMatch) {
                return String(numericDigit)
            }
            guard let digit = String(firstMatch).intValue else { return nil }
            return String(digit)
        }

        static func lastDigit(in input: String) -> String? {
            let foundNumbers = input.ranges(of: digitPattern)
            guard let lastIndex = foundNumbers.reversed().first else { return nil }
            let lastMatch = input[lastIndex]
            if let numericDigit = Int(lastMatch) {
                return String(numericDigit)
            }
            guard let digit = String(lastMatch).intValue else { return nil }
            return String(digit)
        }

        private static let digitPattern = /(zero|one|two|three|four|five|six|seven|eight|nine|[0-9])/
    }
}

private extension String {
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.numberStyle = .spellOut
        return formatter
    }()

    var intValue: Int? {
        Self.numberFormatter.number(from: self) as? Int
    }
}
