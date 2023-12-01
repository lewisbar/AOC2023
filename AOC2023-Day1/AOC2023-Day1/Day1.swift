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
}
