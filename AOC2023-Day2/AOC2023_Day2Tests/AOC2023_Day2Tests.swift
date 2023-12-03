//
//  AOC2023_Day2Tests.swift
//  AOC2023_Day2Tests
//
//  Created by LennartWisbar on 02.12.23.
//

import XCTest

enum Day2 {
    enum Part1 {
        static func parseLine(_ input: String) -> Game? {
            let rawParts = input.components(separatedBy: ": ")

            let rawGameTitle = rawParts[0]

            guard let id = Int(rawGameTitle.components(separatedBy: .whitespaces)[1]) else { return nil }

            let rawRounds = rawParts[1].components(separatedBy: "; ")
            let rounds = rawRounds.map { rawRound in
                var red = 0
                var green = 0
                var blue = 0

                let rawColors = rawRound.components(separatedBy: ", ")

                for rawColor in rawColors {
                    guard let colorValue = Int(rawColor.components(separatedBy: .whitespaces)[0]) else { continue }

                    if rawColor.hasSuffix("red") { red = colorValue }
                    else if rawColor.hasSuffix("green") { green = colorValue }
                    else if rawColor.hasSuffix("blue") { blue = colorValue }
                }

                return Round(red: red, green: green, blue: blue)
            }

            return Game(id: id, rounds: rounds)
        }
    }
}

struct Game: Equatable {
    let id: Int
    let rounds: [Round]
}

struct Round: Equatable {
    let red: Int
    let green: Int
    let blue: Int
}

final class AOC2023_Day2Tests: XCTestCase {
    func test_parseLine_createsGameModel() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"

        let result = Day2.Part1.parseLine(input)

        let expectedResult = Game(id: 1, rounds: [
            Round(red: 4, green: 0, blue: 3),
            Round(red: 1, green: 2, blue: 6),
            Round(red: 0, green: 2, blue: 0)
        ])

        XCTAssertEqual(result, expectedResult)
    }
}
