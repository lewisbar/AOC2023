//
//  AOC2023_Day1Tests.swift
//  AOC2023_Day1Tests
//
//  Created by LennartWisbar on 01.12.23.
//

import XCTest

extension String {
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

final class AOC2023_Day1Tests: XCTestCase {
    func test_firstDigit_returnsfirstDigit() {
        let input = "pqr3stu8vwx"

        XCTAssertEqual(input.firstDigit, "3")
    }

    func test_lastDigit_returnslastDigit() {
        let input = "pqr3stu8vwx"

        XCTAssertEqual(input.lastDigit, "8")
    }

    func test_calibrationValue_returnsCombinedFirstAndLastDigits() {
        let input = "pqr3stu8vwx"

        XCTAssertEqual(input.calibrationValue, 38)
    }

    func test_calibrationSum_returnsSumOfCalibrationValues() {
        let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """

        XCTAssertEqual(input.calibrationSum, 142)
    }
}
