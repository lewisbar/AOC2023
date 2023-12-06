//
//  Day6.swift
//  Day6
//
//  Created by LennartWisbar on 06.12.23.
//

import Foundation

struct Race: Equatable {
    let duration: Int
    let recordDistance: Int
}

public enum Part1 {
    public static func multipliedWaysToWin(from input: String) -> Int {
        parse(input)
            .map(waysToWin)
            .map { $0.count }
            .reduce(1, *)
    }

    static func parse(_ input: String) -> [Race] {
        let timesAndDistances = input
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: ":")[1] }
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .map { $0.components(separatedBy: .whitespaces).compactMap(Int.init) }

        let times = timesAndDistances[0]
        let distances = timesAndDistances[1]

        return times.enumerated().map { (index, time) in
            Race(duration: time, recordDistance: distances[index])
        }
    }

    static func waysToWin(_ race: Race) -> [Int] {
        var speed = 0
        var recordSpeeds = [Int]()

        while speed < race.duration {
            if distance(forSpeed: speed, duration: race.duration) > race.recordDistance {
                recordSpeeds.append(speed)
            }
            speed += 1
        }

        return recordSpeeds
    }

    static func distance(forSpeed speed: Int, duration: Int) -> Int {
        let remainingDuration = duration - speed
        return speed * remainingDuration
    }
}

public enum Part2 {
    static func parse(_ input: String) -> Race {
        let timeAndDistance = input
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: ":")[1] }
            .map { $0.replacingOccurrences(of: " ", with: "") }
            .compactMap(Int.init)

        return Race(duration: timeAndDistance[0], recordDistance: timeAndDistance[1])
    }

    static func numberOfWaysToWin(_ race: Race) -> Int {
        var speed = 0
        var recordSpeedCount = 0

        while speed < race.duration {
            if Part1.distance(forSpeed: speed, duration: race.duration) > race.recordDistance {
                recordSpeedCount += 1
            }
            speed += 1
        }

        return recordSpeedCount
    }
}
