//
//  Day6Tests.swift
//  Day6Tests
//
//  Created by LennartWisbar on 06.12.23.
//

import XCTest

struct Race: Equatable {
    let duration: Int
    let recordDistance: Int
}

public enum Part1 {
    public static func multipliedWaysToWin(from input: String) -> Int {
        parse(input)
            .map(waysToWin)
            .map { $0.count }
            .reduce(1, *)
    }

    static func parse(_ input: String) -> [Race] {
        let timesAndDistances = input
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: ":")[1] }
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .map { $0.components(separatedBy: .whitespaces).compactMap(Int.init) }

        let times = timesAndDistances[0]
        let distances = timesAndDistances[1]

        return times.enumerated().map { (index, time) in
            Race(duration: time, recordDistance: distances[index])
        }
    }

    static func waysToWin(_ race: Race) -> [Int] {
        var speed = 0
        var recordSpeeds = [Int]()

        while speed < race.duration {
            if distance(forSpeed: speed, duration: race.duration) > race.recordDistance {
                recordSpeeds.append(speed)
            }
            speed += 1
        }

        return recordSpeeds
    }

    static func distance(forSpeed speed: Int, duration: Int) -> Int {
        let remainingDuration = duration - speed
        return speed * remainingDuration
    }
}

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
