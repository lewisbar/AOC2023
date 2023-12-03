//
//  AOC2023_Day2Tests.swift
//  AOC2023_Day2Tests
//
//  Created by LennartWisbar on 02.12.23.
//

import XCTest
@testable import AOC2023_Day2

final class AOC2023_Day2Tests: XCTestCase {
    func test_parseLine_createsGameModel() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"

        let result = Day2.Part1.parseLine(input)

        let expectedResult = Day2.Game(id: 1, rounds: [
            Day2.Round(red: 4, green: 0, blue: 3),
            Day2.Round(red: 1, green: 2, blue: 6),
            Day2.Round(red: 0, green: 2, blue: 0)
        ])

        XCTAssertEqual(result, expectedResult)
    }

    func test_parseLines_createsGameModels() {
        let input = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """

        let result = Day2.Part1.parseLines(input)

        let expectedResult = [
            Day2.Game(id: 1, rounds: [
                Day2.Round(red: 4, green: 0, blue: 3),
                Day2.Round(red: 1, green: 2, blue: 6),
                Day2.Round(red: 0, green: 2, blue: 0)
            ]),
            Day2.Game(id: 2, rounds: [
                Day2.Round(red: 0, green: 2, blue: 1),
                Day2.Round(red: 1, green: 3, blue: 4),
                Day2.Round(red: 0, green: 1, blue: 1)
            ]),
            Day2.Game(id: 3, rounds: [
                Day2.Round(red: 20, green: 8, blue: 6),
                Day2.Round(red: 4, green: 13, blue: 5),
                Day2.Round(red: 1, green: 5, blue: 0)
            ]),
            Day2.Game(id: 4, rounds: [
                Day2.Round(red: 3, green: 1, blue: 6),
                Day2.Round(red: 6, green: 3, blue: 0),
                Day2.Round(red: 14, green: 3, blue: 15)
            ]),
            Day2.Game(id: 5, rounds: [
                Day2.Round(red: 6, green: 3, blue: 1),
                Day2.Round(red: 1, green: 2, blue: 2)
            ]),
        ]

        XCTAssertEqual(result, expectedResult)
    }

    func test_possibleGames_returnsCorrectGames() {
        let games = [
            Day2.Game(id: 1, rounds: [
                Day2.Round(red: 4, green: 0, blue: 3),
                Day2.Round(red: 1, green: 2, blue: 6),
                Day2.Round(red: 0, green: 2, blue: 0)
            ]),
            Day2.Game(id: 2, rounds: [
                Day2.Round(red: 0, green: 2, blue: 1),
                Day2.Round(red: 1, green: 3, blue: 4),
                Day2.Round(red: 0, green: 1, blue: 1)
            ]),
            Day2.Game(id: 3, rounds: [
                Day2.Round(red: 20, green: 8, blue: 6),
                Day2.Round(red: 4, green: 13, blue: 5),
                Day2.Round(red: 1, green: 5, blue: 0)
            ]),
            Day2.Game(id: 4, rounds: [
                Day2.Round(red: 3, green: 1, blue: 6),
                Day2.Round(red: 6, green: 3, blue: 0),
                Day2.Round(red: 14, green: 3, blue: 15)
            ]),
            Day2.Game(id: 5, rounds: [
                Day2.Round(red: 6, green: 3, blue: 1),
                Day2.Round(red: 1, green: 2, blue: 2)
            ]),
        ]

        let cubeSet = Day2.Round(red: 12, green: 13, blue: 14)

        let result = Day2.Part1.possibleGames(outOf: games, for: cubeSet)

        let expectedResult = [
            Day2.Game(id: 1, rounds: [
                Day2.Round(red: 4, green: 0, blue: 3),
                Day2.Round(red: 1, green: 2, blue: 6),
                Day2.Round(red: 0, green: 2, blue: 0)
            ]),
            Day2.Game(id: 2, rounds: [
                Day2.Round(red: 0, green: 2, blue: 1),
                Day2.Round(red: 1, green: 3, blue: 4),
                Day2.Round(red: 0, green: 1, blue: 1)
            ]),
            Day2.Game(id: 5, rounds: [
                Day2.Round(red: 6, green: 3, blue: 1),
                Day2.Round(red: 1, green: 2, blue: 2)
            ]),
        ]

        XCTAssertEqual(result.map(\.id), expectedResult.map(\.id))
        XCTAssertEqual(result, expectedResult)
    }

    func test_sumOfPossibleIDs_returnsCorrectSum() {
        let games = [
            Day2.Game(id: 1, rounds: [
                Day2.Round(red: 4, green: 0, blue: 3),
                Day2.Round(red: 1, green: 2, blue: 6),
                Day2.Round(red: 0, green: 2, blue: 0)
            ]),
            Day2.Game(id: 2, rounds: [
                Day2.Round(red: 0, green: 2, blue: 1),
                Day2.Round(red: 1, green: 3, blue: 4),
                Day2.Round(red: 0, green: 1, blue: 1)
            ]),
            Day2.Game(id: 3, rounds: [
                Day2.Round(red: 20, green: 8, blue: 6),
                Day2.Round(red: 4, green: 13, blue: 5),
                Day2.Round(red: 1, green: 5, blue: 0)
            ]),
            Day2.Game(id: 4, rounds: [
                Day2.Round(red: 3, green: 1, blue: 6),
                Day2.Round(red: 6, green: 3, blue: 0),
                Day2.Round(red: 14, green: 3, blue: 15)
            ]),
            Day2.Game(id: 5, rounds: [
                Day2.Round(red: 6, green: 3, blue: 1),
                Day2.Round(red: 1, green: 2, blue: 2)
            ]),
        ]

        let cubeSet = Day2.Round(red: 12, green: 13, blue: 14)

        let result = Day2.Part1.sumOfPossibleIDs(outOf: games, for: cubeSet)

        XCTAssertEqual(result, 8)
    }

    func test_sumOfPossibleIDsInInput_returnsCorrectSum() {
        let input = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """

        let result = Day2.Part1.sumOfPossibleIDs(in: input, redCubes: 12, greenCubes: 13, blueCubes: 14)

        XCTAssertEqual(result, 8)
    }
}
