//
//  Day5Tests.swift
//  Day5Tests
//
//  Created by LennartWisbar on 05.12.23.
//

import XCTest
@testable import Day5

final class Day5Tests: XCTestCase {
    func test_parseSeeds_returnsListOfSeeds() {
        let input = "seeds: 79 14 55 13"

        let result = Part1.parseSeeds(input)

        XCTAssertEqual(result, [79, 14, 55, 13])
    }

    func test_agriRange_contains_reportsIfKeyIsContained() {
        let range = AgriRange(source: 1, destination: 100, rangeLength: 5)

        let result = [0, 1, 5, 6].map(range.contains)

        XCTAssertEqual(result, [false, true, true, false])
    }

    func test_agriRange_contains_returnsValueForContainedKeys() {
        let range = AgriRange(source: 1, destination: 100, rangeLength: 5)

        let result = [0, 1, 5, 6].map(range.value)

        XCTAssertEqual(result, [0, 100, 104, 6])
    }

    func test_agriMap_isKnownKey_reportsIfKeyIsContainedInKnownRanges() {
        let ranges = [
            AgriRange(source: 2, destination: 99, rangeLength: 5),
            AgriRange(source: 50, destination: 2, rangeLength: 4)
        ]

        let agriMap = AgriMap(knownRanges: ranges)

        let result = [1, 2, 6, 7, 49, 50, 53, 54].map(agriMap.isKnownKey)

        XCTAssertEqual(result, [false, true, true, false, false, true, true, false])
    }

    func test_agriMap_valueForKey_returnsCorrectValuesForKnownAndUnknownKeys() {
        let agriMap = AgriMap(knownRanges: [
            AgriRange(source: 98, destination: 50, rangeLength: 2),
            AgriRange(source: 50, destination: 52, rangeLength: 48)
        ])

        let result = [79, 14, 55, 13].map { agriMap.value(for: $0) }

        XCTAssertEqual(result, [81, 14, 57, 13])
    }

    func test_parseMap_returnsAgriMapWithCorrectKnownRanges() {
        let input = """
        50 98 2
        52 50 48
        """

        let result = Part1.parseMap(input)

        XCTAssertEqual(result.knownRanges, [
            AgriRange(source: 98, destination: 50, rangeLength: 2),
            AgriRange(source: 50, destination: 52, rangeLength: 48)
        ])
    }

    func test_parseInput_returnsAlmanac() {
        let input = """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4
        """

        let result = Part1.parseInput(input)

        let expectedResult = Almanac(
            seeds: [79, 14, 55, 13],
            seedToSoil: AgriMap(knownRanges: [
                AgriRange(source: 98, destination: 50, rangeLength: 2),
                AgriRange(source: 50, destination: 52, rangeLength: 48)
            ]),
            soilToFertilizer: AgriMap(knownRanges: [
                AgriRange(source: 15, destination: 0, rangeLength: 37),
                AgriRange(source: 52, destination: 37, rangeLength: 2),
                AgriRange(source: 0, destination: 39, rangeLength: 15)
            ]),
            fertilizerToWater: AgriMap(knownRanges: [
                AgriRange(source: 53, destination: 49, rangeLength: 8),
                AgriRange(source: 11, destination: 0, rangeLength: 42),
                AgriRange(source: 0, destination: 42, rangeLength: 7),
                AgriRange(source: 7, destination: 57, rangeLength: 4)
            ]),
            waterToLight: AgriMap(knownRanges: [
                AgriRange(source: 18, destination: 88, rangeLength: 7),
                AgriRange(source: 25, destination: 18, rangeLength: 70)
            ]),
            lightToTemperature: AgriMap(knownRanges: [
                AgriRange(source: 77, destination: 45, rangeLength: 23),
                AgriRange(source: 45, destination: 81, rangeLength: 19),
                AgriRange(source: 64, destination: 68, rangeLength: 13)
            ]),
            temperatureToHumidity: AgriMap(knownRanges: [
                AgriRange(source: 69, destination: 0, rangeLength: 1),
                AgriRange(source: 0, destination: 1, rangeLength: 69)
            ]),
            humidityToLocation: AgriMap(knownRanges: [
                AgriRange(source: 56, destination: 60, rangeLength: 37),
                AgriRange(source: 93, destination: 56, rangeLength: 4)
            ])
        )

        XCTAssertEqual(result.seeds, expectedResult.seeds)
        XCTAssertEqual(result.seedToSoil.knownRanges, expectedResult.seedToSoil.knownRanges)
        XCTAssertEqual(result.soilToFertilizer.knownRanges, expectedResult.soilToFertilizer.knownRanges)
        XCTAssertEqual(result.fertilizerToWater.knownRanges, expectedResult.fertilizerToWater.knownRanges)
        XCTAssertEqual(result.waterToLight.knownRanges, expectedResult.waterToLight.knownRanges)
        XCTAssertEqual(result.lightToTemperature.knownRanges, expectedResult.lightToTemperature.knownRanges)
        XCTAssertEqual(result.temperatureToHumidity.knownRanges, expectedResult.temperatureToHumidity.knownRanges)
        XCTAssertEqual(result.humidityToLocation.knownRanges, expectedResult.humidityToLocation.knownRanges)
    }

    func test_almanac_locations_returnsLocationsForItsSeeds() {
        let almanac = Almanac(
            seeds: [79, 14, 55, 13],
            seedToSoil: AgriMap(knownRanges: [
                AgriRange(source: 98, destination: 50, rangeLength: 2),
                AgriRange(source: 50, destination: 52, rangeLength: 48)
            ]),
            soilToFertilizer: AgriMap(knownRanges: [
                AgriRange(source: 15, destination: 0, rangeLength: 37),
                AgriRange(source: 52, destination: 37, rangeLength: 2),
                AgriRange(source: 0, destination: 39, rangeLength: 15)
            ]),
            fertilizerToWater: AgriMap(knownRanges: [
                AgriRange(source: 53, destination: 49, rangeLength: 8),
                AgriRange(source: 11, destination: 0, rangeLength: 42),
                AgriRange(source: 0, destination: 42, rangeLength: 7),
                AgriRange(source: 7, destination: 57, rangeLength: 4)
            ]),
            waterToLight: AgriMap(knownRanges: [
                AgriRange(source: 18, destination: 88, rangeLength: 7),
                AgriRange(source: 25, destination: 18, rangeLength: 70)
            ]),
            lightToTemperature: AgriMap(knownRanges: [
                AgriRange(source: 77, destination: 45, rangeLength: 23),
                AgriRange(source: 45, destination: 81, rangeLength: 19),
                AgriRange(source: 64, destination: 68, rangeLength: 13)
            ]),
            temperatureToHumidity: AgriMap(knownRanges: [
                AgriRange(source: 69, destination: 0, rangeLength: 1),
                AgriRange(source: 0, destination: 1, rangeLength: 69)
            ]),
            humidityToLocation: AgriMap(knownRanges: [
                AgriRange(source: 56, destination: 60, rangeLength: 37),
                AgriRange(source: 93, destination: 56, rangeLength: 4)
            ])
        )

        XCTAssertEqual(almanac.locations, [82, 43, 86, 35])
    }

    func test_lowestLocationNumber_returnsCorrectNumberFromInput() {
        let input = """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4
        """

        let result = Part1.lowestLocationNumber(from: input)

        XCTAssertEqual(result, 35)
    }
}
