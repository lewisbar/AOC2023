//
//  Day6Tests.swift
//  Day6Tests
//
//  Created by LennartWisbar on 06.12.23.
//

import XCTest

public enum Part1 {
    static func distance(forSpeed speed: Int, duration: Int) -> Int {
        let remainingDuration = duration - speed
        return speed * remainingDuration
    }
}

final class Day6Tests: XCTestCase {
    func test_distanceForPressingTime_returnsCorrectDistance() {
        let distances = [0, 1, 2, 3, 4, 5, 6, 7]

        let result = distances.map { Part1.distance(forSpeed: $0, duration: 7) }

        XCTAssertEqual(result, [0, 6, 10, 12, 12, 10, 6, 0])
    }
}
