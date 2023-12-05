//
//  Day5Tests.swift
//  Day5Tests
//
//  Created by LennartWisbar on 05.12.23.
//

import XCTest

struct AgriRange: Equatable {
    let source: Int
    let destination: Int
    let rangeLength: Int

    private var sourceRange: Range<Int> {
        source..<source + rangeLength
    }

    func contains(_ key: Int) -> Bool {
        (sourceRange).contains(key)
    }

    func value(for key: Int) -> Int {
        switch contains(key) {
        case true:
            let difference = destination - source
            return key + difference
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

class Almanac {
    let seeds: [Int]
    let seedToSoil: AgriMap
    let soilToFertilizer: AgriMap
    let fertilizerToWater: AgriMap
    let waterToLight: AgriMap
    let lightToTemperature: AgriMap
    let temperatureToHumidity: AgriMap
    let humidityToLocation: AgriMap

    init(seeds: [Int], seedToSoil: AgriMap, soilToFertilizer: AgriMap, fertilizerToWater: AgriMap, waterToLight: AgriMap, lightToTemperature: AgriMap, temperatureToHumidity: AgriMap, humidityToLocation: AgriMap) {
        self.seeds = seeds
        self.seedToSoil = seedToSoil
        self.soilToFertilizer = soilToFertilizer
        self.fertilizerToWater = fertilizerToWater
        self.waterToLight = waterToLight
        self.lightToTemperature = lightToTemperature
        self.temperatureToHumidity = temperatureToHumidity
        self.humidityToLocation = humidityToLocation
    }

    var locations: [Int] {
        seeds
            .map(seedToSoil.value)
            .map(soilToFertilizer.value)
            .map(fertilizerToWater.value)
            .map(waterToLight.value)
            .map(lightToTemperature.value)
            .map(temperatureToHumidity.value)
            .map(humidityToLocation.value)
    }
}

public enum Part1 {
    public static func lowestLocationNumber(from input: String) -> Int? {
        parseInput(input).locations.min()
    }

    static func parseInput(_ input: String) -> Almanac {
        let blocks = input.components(separatedBy: "\n\n")

        return Almanac(
            seeds: parseSeeds(blocks[0]),
            seedToSoil: parseMap(trimFirstLine(from: blocks[1])),
            soilToFertilizer: parseMap(trimFirstLine(from: blocks[2])),
            fertilizerToWater: parseMap(trimFirstLine(from: blocks[3])),
            waterToLight: parseMap(trimFirstLine(from: blocks[4])),
            lightToTemperature: parseMap(trimFirstLine(from: blocks[5])),
            temperatureToHumidity: parseMap(trimFirstLine(from: blocks[6])),
            humidityToLocation: parseMap(trimFirstLine(from: blocks[7]))
        )
    }

    private static func trimFirstLine(from input: String) -> String {
        String(input.components(separatedBy: .newlines).dropFirst().joined(separator: "\n"))
    }

    static func parseSeeds(_ input: String) -> [Int] {
        input
            .components(separatedBy: ": ")[1]
            .components(separatedBy: .whitespaces)
            .compactMap(Int.init)
    }

    static func parseMap(_ input: String) -> AgriMap {
        let ranges = input
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: .whitespaces).compactMap(Int.init) }
            .map { AgriRange(source: $0[1], destination: $0[0], rangeLength: $0[2]) }

        return AgriMap(knownRanges: ranges)
    }
}

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
