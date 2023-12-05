//
//  Day5.swift
//  Day5
//
//  Created by LennartWisbar on 05.12.23.
//

import Foundation

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
