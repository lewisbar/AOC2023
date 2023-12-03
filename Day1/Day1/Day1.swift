//
//  Day1.swift
//  Day1
//
//  Created by LennartWisbar on 01.12.23.
//

import Foundation

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
        let reversedInput = String(input.reversed())
        
        let foundNumbers = reversedInput.ranges(of: reversedDigitPattern)
        guard let firstIndex = foundNumbers.first else { return nil }
        let firstMatch = String(reversedInput[firstIndex].reversed())
        if let numericDigit = Int(firstMatch) {
            return String(numericDigit)
        }
        guard let digit = String(firstMatch).intValue else { return nil }
        return String(digit)
    }
    
    private static let digitPattern = /(zero|one|two|three|four|five|six|seven|eight|nine|[0-9])/
    private static let reversedDigitPattern = /(orez|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|[0-9])/
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
