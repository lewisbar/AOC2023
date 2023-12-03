//
//  AOC2023_Day2Tests.swift
//  AOC2023_Day2Tests
//
//  Created by LennartWisbar on 02.12.23.
//

import XCTest

enum Day2 {
    enum Part1 {
        static func possibleGames(outOf games: [Game], for cubeSet: Round) -> [Game] {
            games.filter { game in
                game.rounds.allSatisfy { round in
                    round.red <= cubeSet.red && round.green <= cubeSet.green && round.blue <= cubeSet.blue
                }
            }
        }

        static func parseLines(_ input: String) -> [Game] {
            input.components(separatedBy: .newlines).compactMap(parseLine)
        }

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
            Game(id: 1, rounds: [
                Round(red: 4, green: 0, blue: 3),
                Round(red: 1, green: 2, blue: 6),
                Round(red: 0, green: 2, blue: 0)
            ]),
            Game(id: 2, rounds: [
                Round(red: 0, green: 2, blue: 1),
                Round(red: 1, green: 3, blue: 4),
                Round(red: 0, green: 1, blue: 1)
            ]),
            Game(id: 3, rounds: [
                Round(red: 20, green: 8, blue: 6),
                Round(red: 4, green: 13, blue: 5),
                Round(red: 1, green: 5, blue: 0)
            ]),
            Game(id: 4, rounds: [
                Round(red: 3, green: 1, blue: 6),
                Round(red: 6, green: 3, blue: 0),
                Round(red: 14, green: 3, blue: 15)
            ]),
            Game(id: 5, rounds: [
                Round(red: 6, green: 3, blue: 1),
                Round(red: 1, green: 2, blue: 2)
            ]),
        ]

        XCTAssertEqual(result, expectedResult)
    }

    func test_possibleGames_returnsCorrectGames() {
        let games = [
            Game(id: 1, rounds: [
                Round(red: 4, green: 0, blue: 3),
                Round(red: 1, green: 2, blue: 6),
                Round(red: 0, green: 2, blue: 0)
            ]),
            Game(id: 2, rounds: [
                Round(red: 0, green: 2, blue: 1),
                Round(red: 1, green: 3, blue: 4),
                Round(red: 0, green: 1, blue: 1)
            ]),
            Game(id: 3, rounds: [
                Round(red: 20, green: 8, blue: 6),
                Round(red: 4, green: 13, blue: 5),
                Round(red: 1, green: 5, blue: 0)
            ]),
            Game(id: 4, rounds: [
                Round(red: 3, green: 1, blue: 6),
                Round(red: 6, green: 3, blue: 0),
                Round(red: 14, green: 3, blue: 15)
            ]),
            Game(id: 5, rounds: [
                Round(red: 6, green: 3, blue: 1),
                Round(red: 1, green: 2, blue: 2)
            ]),
        ]

        let cubeSet = Round(red: 12, green: 13, blue: 14)

        let result = Day2.Part1.possibleGames(outOf: games, for: cubeSet)

        let expectedResult = [
            Game(id: 1, rounds: [
                Round(red: 4, green: 0, blue: 3),
                Round(red: 1, green: 2, blue: 6),
                Round(red: 0, green: 2, blue: 0)
            ]),
            Game(id: 2, rounds: [
                Round(red: 0, green: 2, blue: 1),
                Round(red: 1, green: 3, blue: 4),
                Round(red: 0, green: 1, blue: 1)
            ]),
            Game(id: 5, rounds: [
                Round(red: 6, green: 3, blue: 1),
                Round(red: 1, green: 2, blue: 2)
            ]),
        ]

        XCTAssertEqual(result.map(\.id), expectedResult.map(\.id))
        XCTAssertEqual(result, expectedResult)
    }
}
