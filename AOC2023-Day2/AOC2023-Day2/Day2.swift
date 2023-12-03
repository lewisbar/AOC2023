//
//  Day2.swift
//  AOC2023-Day2
//
//  Created by LennartWisbar on 03.12.23.
//

import Foundation

public enum Day2 {
    struct Game: Equatable {
        let id: Int
        let rounds: [Round]
    }

    struct Round: Equatable {
        let red: Int
        let green: Int
        let blue: Int
    }

    public enum Part1 {
        public static func sumOfPossibleIDs(in input: String, redCubes: Int, greenCubes: Int, blueCubes: Int) -> Int {
            let games = parseLines(input)
            let cubeSet = Round(red: redCubes, green: greenCubes, blue: blueCubes)
            return sumOfPossibleIDs(outOf: games, for: cubeSet)
        }

        static func sumOfPossibleIDs(outOf games: [Game], for cubeSet: Round) -> Int {
            possibleGames(outOf: games, for: cubeSet).map(\.id).reduce(0, +)
        }

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

    public enum Part2 {
        public static func sumOfPowerOfMinimumCubeSets(for input: String) -> Int {
            let games = Part1.parseLines(input)
            return sumOfPowerOfMinimumCubeSets(for: games)
        }

        static func sumOfPowerOfMinimumCubeSets(for games: [Game]) -> Int {
            games
                .map(minimumCubeSet)
                .map(power)
                .reduce(0, +)
        }

        static func power(of round: Round) -> Int {
            round.red * round.green * round.blue
        }
        
        static func minimumCubeSet(for game: Game) -> Round {
            var red = 0
            var green = 0
            var blue = 0

            for round in game.rounds {
                red = max(red, round.red)
                green = max(green, round.green)
                blue = max(blue, round.blue)
            }

            return Round(red: red, green: green, blue: blue)
        }
    }
}
