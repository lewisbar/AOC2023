//
//  Solutions.swift
//  Solutions
//
//  Created by LennartWisbar on 03.12.23.
//

import Foundation
import Day1
import Day2

enum Solutions {
    struct DaySummary: Identifiable {
        let id: String
        let solution1: String
        let solution2: String
    }

    // MARK: - Private

    static var daySummaries: [DaySummary] {
        [Day1Solutions.summary, Day2Solutions.summary]
    }

    private enum Day1Solutions {
        static var summary: DaySummary {
            DaySummary(id: "1", solution1: part1, solution2: part2)
        }

        static var part1: String {
            let input = Day1Input.input
            if let result = Day1.Part1.calibrationSum(in: input) {
                return String(result)
            }
            return "No solution"
        }

        static var part2: String {
            let input = Day1Input.input
            if let result = Day1.Part2.calibrationSum(in: input) {
                return String(result)
            }
            return "No solution"
        }
    }

    private enum Day2Solutions {
        static var summary: DaySummary {
            DaySummary(id: "2", solution1: part1, solution2: part2)
        }

        static var part1: String {
            let input = Day2Input.input
            let result = Day2.Part1.sumOfPossibleIDs(in: input, redCubes: 12, greenCubes: 13, blueCubes: 14)
            return String(result)
        }

        static var part2: String {
            let input = Day2Input.input
            let result = Day2.Part2.sumOfPowerOfMinimumCubeSets(for: input)
            return String(result)
        }
    }
}
