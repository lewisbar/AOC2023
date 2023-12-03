//
//  Day1Tests.swift
//  Day1Tests
//
//  Created by LennartWisbar on 01.12.23.
//

import XCTest
@testable import Day1

final class AOC2023_Day1Tests: XCTestCase {

    // MARK: Part 1

    func test_firstDigit_returnsfirstDigit() {
        let input = "pqr3stu8vwx"

        let result = Part1.firstDigit(in: input)

        XCTAssertEqual(result, "3")
    }

    func test_lastDigit_returnslastDigit() {
        let input = "pqr3stu8vwx"

        let result = Part1.lastDigit(in: input)

        XCTAssertEqual(result, "8")
    }

    func test_calibrationValue_returnsCombinedFirstAndLastDigits() {
        let input = "pqr3stu8vwx"

        let result = Part1.calibrationValue(in: input)

        XCTAssertEqual(result, 38)
    }

    func test_calibrationSum_returnsSumOfCalibrationValues() {
        let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """

        let result = Part1.calibrationSum(in: input)

        XCTAssertEqual(result, 142)
    }

    // MARK: Part 2

    func test_firstDigit_returnsFirstSpelledOutNumber() {
        let input = "eightwothree"

        let result = Part2.firstDigit(in: input)

        XCTAssertEqual(result, "8")
    }

    func test_lastDigit_returnsLastSpelledOutNumber() {
        let input = "eightwothree"

        let result = Part2.lastDigit(in: input)

        XCTAssertEqual(result, "3")
    }

    func test_firstDigit_returnsFirstNumericNumber() {
        let input = "8wothree"

        let result = Part2.firstDigit(in: input)

        XCTAssertEqual(result, "8")
    }

    func test_lastDigit_returnsLastNumericNumber() {
        let input = "eightwo3"

        let result = Part2.lastDigit(in: input)

        XCTAssertEqual(result, "3")
    }

    func test_calibrationValue_returnsCombinedFirstAndLastDigitsForPart2() {
        let input = "eightwothree"

        let result = Part2.calibrationValue(in: input)

        XCTAssertEqual(result, 83)
    }

    func test_calibrationValue_returnsCombinedFirstAndLastDigitsForPart2WithOverlappingNumbers() {
        let input = "sevenine"

        let result = Part2.calibrationValue(in: input)

        XCTAssertEqual(result, 79)
    }

    func test_calibrationSum_returnsSumOfCalibrationValuesForPart2() {
        let input = """
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """

        let result = Part2.calibrationSum(in: input)

        XCTAssertEqual(result, 281)
    }
}
