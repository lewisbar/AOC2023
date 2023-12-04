//
//  Day4.swift
//  Day4
//
//  Created by LennartWisbar on 04.12.23.
//

import Foundation

public enum Part1 {
    public static func points(for input: String) -> Int {
        parseLines(input)
            .map(wonNumbers)
            .map { points(for: $0.count) }
            .reduce(0, +)
    }

    static func parseLines(_ input: String) -> [(winningNumbers: [Int], ownedNumbers: [Int])] {
        input
            .components(separatedBy: .newlines)
            .map(parseLine)
    }

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

    static func wonNumbers(outOf ownedNumbers: [Int], winningNumbers: [Int]) -> [Int] {
        ownedNumbers.filter(winningNumbers.contains)
    }
}

public enum Part2 {
    struct Card: Equatable {
        let id: Int
        let winningNumbers: [Int]
        let ownedNumbers: [Int]
    }

    static func directlyWonCards(withCardIndex cardIndex: Int, outOf allCards: [Card]) -> [Card] {
        let currentCard = allCards[cardIndex]

        let winningNumberCount = Part1.wonNumbers(outOf: currentCard.ownedNumbers, winningNumbers: currentCard.winningNumbers).count

        let firstNewCardIndex = cardIndex + 1
        let lastNewCardIndex = cardIndex + winningNumberCount

        guard firstNewCardIndex < allCards.count, lastNewCardIndex < allCards.count, firstNewCardIndex < lastNewCardIndex else { return [] }

        return Array(allCards[cardIndex+1...cardIndex+winningNumberCount])
    }
}
