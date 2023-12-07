//
//  Day7.swift
//  Day7
//
//  Created by LennartWisbar on 07.12.23.
//

import Foundation

struct Hand: Equatable, Comparable {
    let type: HandType
    let cards: [Int]
    let bid: Int
    let sortString: String

    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.type == rhs.type {
            return lhs.sortString < rhs.sortString
        }
        return lhs.type < rhs.type
    }
}

enum HandType: Int, Comparable {
    case fiveOfAKind = 6
    case fourOfAKind = 5
    case fullHouse = 4
    case threeOfAKind = 3
    case twoPair = 2
    case onePair = 1
    case highCard = 0

    static func < (lhs: HandType, rhs: HandType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

public enum Part1 {
    static func totalWinnings(from hands: [Hand]) -> Int {
        let sortedHands = hands.sorted()
        var winnings = 0

        for (index, hand) in sortedHands.enumerated() {
            winnings += hand.bid * (index + 1)
            print("Hand", hand.type)
            print("Cards", hand.cards)
            print("Bid", hand.bid)
            print("Rank", index + 1)
        }

        return winnings
    }

    static func parseHands(from input: String) -> [Hand] {
        input
            .components(separatedBy: .newlines)
            .compactMap(parseHand)
    }

    static func parseHand(from input: String) -> Hand? {
        let cardsAndBid = input.components(separatedBy: .whitespaces)

        let rawCards = cardsAndBid[0]
        let cards = mapToInt(rawCards)
        let type = handType(for: cards)
        let sortString = convertToSortString(rawCards)

        guard let bid = Int(cardsAndBid[1]) else { return nil }

        return Hand(type: type, cards: cards, bid: bid, sortString: sortString)
    }

    private static func mapToInt(_ input: String) -> [Int] {
        input
            .map(String.init)
            .map { $0.replacingOccurrences(of: "A", with: "14") }
            .map { $0.replacingOccurrences(of: "K", with: "13") }
            .map { $0.replacingOccurrences(of: "Q", with: "12") }
            .map { $0.replacingOccurrences(of: "J", with: "11") }
            .map { $0.replacingOccurrences(of: "T", with: "10") }
            .compactMap(Int.init)
    }

    private static func convertToSortString(_ input: String) -> String {
        input
            .replacingOccurrences(of: "A", with: "Z")
            .replacingOccurrences(of: "K", with: "Y")
            .replacingOccurrences(of: "Q", with: "X")
            .replacingOccurrences(of: "J", with: "W")
            .replacingOccurrences(of: "T", with: "V")
    }

    private static func handType(for cards: [Int]) -> HandType {
        if handIsFiveOfAKind(cards) { return .fiveOfAKind }
        if handIsFourOfAKind(cards) { return .fourOfAKind }
        if handIsFullHouse(cards) { return .fullHouse }
        if handHasThreeOfAKind(cards) { return .threeOfAKind }
        if handIsTwoPair(cards) { return .twoPair }
        if handHasExactlyOnePair(cards) { return .onePair }
        return .highCard
    }

    private static func handIsFiveOfAKind(_ cards: [Int]) -> Bool {
        cards.allSatisfy { $0 == cards[0] }
    }

    private static func handIsFourOfAKind(_ cards: [Int]) -> Bool {
        maxEqualCards(in: cards) == 4
    }

    private static func handIsFullHouse(_ cards: [Int]) -> Bool {
        handHasThreeOfAKind(cards) && handHasExactlyOnePair(cards)
    }

    private static func handHasThreeOfAKind(_ cards: [Int]) -> Bool {
        maxEqualCards(in: cards) == 3
    }

    private static func handIsTwoPair(_ cards: [Int]) -> Bool {
        var equalCardCount = 1
        var pairedCardsCount = 0

        for card in cards {
            let equals = cards.filter { $0 == card }
            if equals.count == 2 {
                pairedCardsCount += 1
            }
        }

        return (pairedCardsCount / 2) == 2
    }

    private static func handHasExactlyOnePair(_ cards: [Int]) -> Bool {
        var equalCardCount = 1
        var pairedCardsCount = 0

        for card in cards {
            let equals = cards.filter { $0 == card }
            if equals.count == 2 {
                pairedCardsCount += 1
            }
        }

        return (pairedCardsCount / 2) == 1
    }

    private static func maxEqualCards(in cards: [Int]) -> Int {
        var equalCardCount = 1

        for card in cards {
            let equals = cards.filter { $0 == card }
            if equals.count > equalCardCount {
                equalCardCount = equals.count
            }
        }

        return equalCardCount
    }
}
