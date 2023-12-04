//
//  Day4Tests.swift
//  Day4Tests
//
//  Created by LennartWisbar on 04.12.23.
//

import XCTest

enum Part1 {
    static func points(for winningNumberCount: Int) -> Int {
        Int(pow(2, Double(winningNumberCount - 1)))
    }
}

final class Day4Tests: XCTestCase {
    func test_pointsForWinningNumberCount_calculatesCorrectPoints() {
        let counts = [1, 2, 3, 4, 5]

        let results = counts.map(Part1.points)

        XCTAssertEqual(results, [1, 2, 4, 8, 16])
    }
}
