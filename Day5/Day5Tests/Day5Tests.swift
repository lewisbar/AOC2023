//
//  Day5Tests.swift
//  Day5Tests
//
//  Created by LennartWisbar on 05.12.23.
//

import XCTest

enum Part1 {
    static func parseSeeds(_ input: String) -> [Int] {
        input
            .components(separatedBy: ": ")[1]
            .components(separatedBy: .whitespaces)
            .compactMap(Int.init)
    }
}

final class Day5Tests: XCTestCase {
    func test_parseSeeds_returnsListOfSeeds() {
        let input = "seeds: 79 14 55 13"

        let result = Part1.parseSeeds(input)

        XCTAssertEqual(result, [79, 14, 55, 13])
    }
}
