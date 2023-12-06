//
//  Day6Tests.swift
//  Day6Tests
//
//  Created by LennartWisbar on 06.12.23.
//

import XCTest
@testable import Day6

final class Day6Tests: XCTestCase {
    func test_distanceForPressingTime_returnsCorrectDistance() {
        let distances = [0, 1, 2, 3, 4, 5, 6, 7]

        let result = distances.map { Part1.distance(forSpeed: $0, duration: 7) }

        XCTAssertEqual(result, [0, 6, 10, 12, 12, 10, 6, 0])
    }

    func test_parse_returnsTuplesOfTimesRecordDistances() {
        let input = """
        Time:      7  15   30
        Distance:  9  40  200
        """

        let result = Part1.parse(input)

        XCTAssertEqual(result, [
            Race(duration: 7, recordDistance: 9),
            Race(duration: 15, recordDistance: 40),
            Race(duration: 30, recordDistance: 200)
        ])
    }

    func test_waysToWin_returnsSpeedsThatWouldBreakTheRecord() {
        let races = [
            Race(duration: 7, recordDistance: 9),
            Race(duration: 15, recordDistance: 40),
            Race(duration: 30, recordDistance: 200)
        ]

        let result = races.map(Part1.waysToWin)

        XCTAssertEqual(result, [
            Array(2...5),
            Array(4...11),
            Array(11...19)
        ])
    }

    func test_multipliedWaysToWin_returnsWaysToWinForEachRaceMultipliedByEachOther() {
        let input = """
        Time:      7  15   30
        Distance:  9  40  200
        """

        let result = Part1.multipliedWaysToWin(from: input)

        XCTAssertEqual(result, 288)
    }
}
