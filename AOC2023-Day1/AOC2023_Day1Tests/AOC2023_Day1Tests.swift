//
//  AOC2023_Day1Tests.swift
//  AOC2023_Day1Tests
//
//  Created by LennartWisbar on 01.12.23.
//

import XCTest
import AOC2023_Day1

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
