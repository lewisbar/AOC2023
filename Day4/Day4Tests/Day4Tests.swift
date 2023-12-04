//
//  Day4Tests.swift
//  Day4Tests
//
//  Created by LennartWisbar on 04.12.23.
//

import XCTest

public enum Part1 {
    public static func points(for input: String) -> Int {
        parseLines(input)
            .map(winningNumbers)
            .map { points(for: $0.count) }
            .reduce(0, +)
    }

    static func parseLines(_ input: String) -> [(winningNumbers: [Int], ownedNumbers: [Int])] {
        input
            .components(separatedBy: .newlines)
            .map(parseLine)
    }

    static func parseLine(_ input: String) -> (winningNumbers: [Int], ownedNumbers: [Int]) {
        let components = input
            .components(separatedBy: ": ")[1]
            .components(separatedBy: " | ")
            .map { $0.components(separatedBy: .whitespaces).compactMap(Int.init) }

        return (components[0], components[1])
    }

    static func points(for winningNumberCount: Int) -> Int {
        Int(pow(2, Double(winningNumberCount - 1)))
    }

    static func winningNumbers(outOf myNumbers: [Int], possibleWinners: [Int]) -> [Int] {
        myNumbers.filter(possibleWinners.contains)
    }
}

final class Day4Tests: XCTestCase {
    func test_parseLine_returnsWinningAndOwnedNumbers() {
        let input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"

        let result = Part1.parseLine(input)

        XCTAssertEqual(result.winningNumbers, [41, 48, 83, 86, 17])
        XCTAssertEqual(result.ownedNumbers, [83, 86, 6, 31, 17, 9, 48, 53])
    }

    func test_parseLines_returnsArrayOfParsedLines() {
        let input = """
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """

        let result = Part1.parseLines(input)

        let expectedResult = [
            ([41, 48, 83, 86, 17], [83, 86,  6, 31, 17,  9, 48, 53]),
            ([13, 32, 20, 16, 61], [61, 30, 68, 82, 17, 32, 24, 19]),
            ([ 1, 21, 53, 59, 44], [69, 82, 63, 72, 16, 21, 14,  1]),
            ([41, 92, 73, 84, 69], [59, 84, 76, 51, 58,  5, 54, 83]),
            ([87, 83, 26, 28, 32], [88, 30, 70, 12, 93, 22, 82, 36]),
            ([31, 18, 13, 56, 72], [74, 77, 10, 23, 35, 67, 36, 11])
        ]

        XCTAssertEqual(result.map { $0.0 }, expectedResult.map { $0.0 })
        XCTAssertEqual(result.map { $0.1 }, expectedResult.map { $0.1 })
    }

    func test_pointsForWinningNumberCount_calculatesCorrectPoints() {
        let counts = [1, 2, 3, 4, 5]

        let results = counts.map(Part1.points)

        XCTAssertEqual(results, [1, 2, 4, 8, 16])
    }

    func test_winningNumbers_findsMatchingNumbers() {
        let possibleWinners = [41, 48, 83, 86, 17]
        let myNumbers = [83, 86, 6, 31, 17, 9, 48, 53]

        let result = Part1.winningNumbers(outOf: myNumbers, possibleWinners: possibleWinners)

        XCTAssertEqual(result, [83, 86, 17, 48])
    }

    func test_pointsForInput_returnsCorrectOverallPoints() {
        let input = """
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """

        let result = Part1.points(for: input)

        XCTAssertEqual(result, 13)
    }
}
