//
//  AOC2023_Day1Tests.swift
//  AOC2023_Day1Tests
//
//  Created by LennartWisbar on 01.12.23.
//

import XCTest
@testable import AOC2023_Day1

final class AOC2023_Day1Tests: XCTestCase {
    func test_firstDigit_returnsfirstDigit() {
        let input = "pqr3stu8vwx"

        let result = Day1.Part1.firstDigit(in: input)

        XCTAssertEqual(result, "3")
    }

    func test_lastDigit_returnslastDigit() {
        let input = "pqr3stu8vwx"

        let result = Day1.Part1.lastDigit(in: input)

        XCTAssertEqual(result, "8")
    }

    func test_calibrationValue_returnsCombinedFirstAndLastDigits() {
        let input = "pqr3stu8vwx"

        let result = Day1.Part1.calibrationValue(in: input)

        XCTAssertEqual(result, 38)
    }

    func test_calibrationSum_returnsSumOfCalibrationValues() {
        let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """

        let result = Day1.Part1.calibrationSum(in: input)

        XCTAssertEqual(result, 142)
    }
}
