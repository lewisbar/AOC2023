//
//  Day5Tests.swift
//  Day5Tests
//
//  Created by LennartWisbar on 05.12.23.
//

import XCTest

class AgriMap {
    private let knownValues: [Int: Int]

    init(knownValues: [Int : Int]) {
        self.knownValues = knownValues
    }

    func value(for key: Int) -> Int {
        knownValues[key] ?? key
    }
}

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

    func test_agriMap_valueForKey_returnsValuesForKnownKeys() {
        let agriMap = AgriMap(knownValues: [
            5: 10,
            6: 12,
            7: 15
        ])

        let result = [5, 6, 7].map { agriMap.value(for: $0) }

        XCTAssertEqual(result, [10, 12, 15])
    }

    func test_agriMap_valueForKey_returnsValuesForUnknownKeys() {
        let agriMap = AgriMap(knownValues: [
            5: 10,
            6: 12,
            7: 15
        ])

        let result = [1, 4, 8].map { agriMap.value(for: $0) }

        XCTAssertEqual(result, [1, 4, 8])
    }

}
