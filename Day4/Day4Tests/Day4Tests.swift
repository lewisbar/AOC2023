//
//  Day4Tests.swift
//  Day4Tests
//
//  Created by LennartWisbar on 04.12.23.
//

import XCTest
@testable import Day4

final class Day4Tests: XCTestCase {

    // MARK: - Part 1

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
        let winningNumbers = [41, 48, 83, 86, 17]
        let myNumbers = [83, 86, 6, 31, 17, 9, 48, 53]

        let result = Part1.wonNumbers(outOf: myNumbers, winningNumbers: winningNumbers)

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

    // MARK: - Part 2

    func test_wonCards_returnsListOfWonCards() {
        let allCards = [
            Part2.Card(id: 1, winningNumbers: [41, 48, 83, 86, 17], ownedNumbers: [83, 86,  6, 31, 17,  9, 48, 53]),
            Part2.Card(id: 2, winningNumbers: [13, 32, 20, 16, 61], ownedNumbers: [61, 30, 68, 82, 17, 32, 24, 19]),
            Part2.Card(id: 3, winningNumbers: [ 1, 21, 53, 59, 44], ownedNumbers: [69, 82, 63, 72, 16, 21, 14,  1]),
            Part2.Card(id: 4, winningNumbers: [41, 92, 73, 84, 69], ownedNumbers: [59, 84, 76, 51, 58,  5, 54, 83]),
            Part2.Card(id: 5, winningNumbers: [87, 83, 26, 28, 32], ownedNumbers: [88, 30, 70, 12, 93, 22, 82, 36]),
            Part2.Card(id: 6, winningNumbers: [31, 18, 13, 56, 72], ownedNumbers: [74, 77, 10, 23, 35, 67, 36, 11])
        ]

        let result = Part2.directlyWonCards(withCardIndex: 0, outOf: allCards)

        XCTAssertEqual(result, [allCards[1], allCards[2], allCards[3], allCards[4]])
    }
}
