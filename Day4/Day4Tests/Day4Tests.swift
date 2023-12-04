//
//  Day4Tests.swift
//  Day4Tests
//
//  Created by LennartWisbar on 04.12.23.
//

import XCTest

enum Part1 {
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
}
