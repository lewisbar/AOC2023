//
//  Day5Tests.swift
//  Day5Tests
//
//  Created by LennartWisbar on 05.12.23.
//

import XCTest

struct AgriRange {
    let startKey: Int
    let startValue: Int
    let rangeLength: Int

    private var keyRange: Range<Int> {
        startKey..<startKey + rangeLength
    }

    func contains(_ key: Int) -> Bool {
        (keyRange).contains(key)
    }

    func value(for key: Int) -> Int {
        switch contains(key) {
        case true:
            let difference = key - startKey
            return startValue + difference
        case false:
            return key
        }
    }
}

class AgriMap {
    let knownRanges: [AgriRange]

    init(knownRanges: [AgriRange]) {
        self.knownRanges = knownRanges
    }

    func isKnownKey(_ key: Int) -> Bool {
        knownRanges.first(where: { $0.contains(key) }) != nil
    }

    func rangeContaining(_ key: Int) -> AgriRange? {
        knownRanges.first(where: { $0.contains(key) })
    }

    func value(for key: Int) -> Int {
        if let range = rangeContaining(key) {
            return range.value(for: key)
        }
        return key
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

    func test_agriRange_contains_reportsIfKeyIsContained() {
        let range = AgriRange(startKey: 1, startValue: 100, rangeLength: 5)

        let result = [0, 1, 5, 6].map(range.contains)

        XCTAssertEqual(result, [false, true, true, false])
    }

    func test_agriRange_contains_returnsValueForContainedKeys() {
        let range = AgriRange(startKey: 1, startValue: 100, rangeLength: 5)

        let result = [0, 1, 5, 6].map(range.value)

        XCTAssertEqual(result, [0, 100, 104, 6])
    }

    func test_agriMap_isKnownKey_reportsIfKeyIsContainedInKnownRanges() {
        let ranges = [
            AgriRange(startKey: 2, startValue: 99, rangeLength: 5),
            AgriRange(startKey: 50, startValue: 2, rangeLength: 4)
        ]

        let agriMap = AgriMap(knownRanges: ranges)

        let result = [1, 2, 6, 7, 49, 50, 53, 54].map(agriMap.isKnownKey)

        XCTAssertEqual(result, [false, true, true, false, false, true, true, false])
    }

    func test_agriMap_valueForKey_returnsCorrectValuesForKnownAndUnknownKeys() {
        let agriMap = AgriMap(knownRanges: [
            AgriRange(startKey: 50, startValue: 98, rangeLength: 2),
            AgriRange(startKey: 52, startValue: 50, rangeLength: 48)
        ])

        let result = [49, 50, 51, 52, 99, 100].map { agriMap.value(for: $0) }

        XCTAssertEqual(result, [49, 98, 99, 50, 97, 100])
    }

}
