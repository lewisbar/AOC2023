//
//  Solutions.swift
//  AOC2023-Solutions
//
//  Created by LennartWisbar on 03.12.23.
//

import Foundation
import AOC2023_Day1
import AOC2023_Day2

enum Solutions {
    struct DaySummary: Identifiable {
        let id: String
        let solution1: String
        let solution2: String
    }

    // MARK: - Private

    static var daySummaries: [DaySummary] {
        [Day1.summary, Day2.summary]
    }

    private enum Day1 {
        static var summary: DaySummary {
            DaySummary(id: "1", solution1: part1, solution2: part2)
        }

        static var part1: String {
            let input = Day1Input.input
            if let result = AOC2023_Day1.Day1.Part1.calibrationSum(in: input) {
                return String(result)
            }
            return "No solution"
        }

        static var part2: String {
            let input = Day1Input.input
            if let result = AOC2023_Day1.Day1.Part2.calibrationSum(in: input) {
                return String(result)
            }
            return "No solution"
        }
    }

    private enum Day2 {
        static var summary: DaySummary {
            DaySummary(id: "2", solution1: part1, solution2: part2)
        }

        static var part1: String {
            let input = Day2Input.input
            let result = AOC2023_Day2.Day2.Part1.sumOfPossibleIDs(in: input, redCubes: 12, greenCubes: 13, blueCubes: 14)
            return String(result)
        }

        static var part2: String {
            let input = Day2Input.input
            let result = AOC2023_Day2.Day2.Part2.sumOfPowerOfMinimumCubeSets(for: input)
            return String(result)
        }
    }
}
