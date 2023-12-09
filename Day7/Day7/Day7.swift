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

protocol HandEvaluator {
    static func handIsFiveOfAKind(_ cards: [Int]) -> Bool
    static func handIsFourOfAKind(_ cards: [Int]) -> Bool
    static func handIsFullHouse(_ cards: [Int]) -> Bool
    static func handHasThreeOfAKind(_ cards: [Int]) -> Bool
    static func handIsTwoPair(_ cards: [Int]) -> Bool
    static func handHasExactlyOnePair(_ cards: [Int]) -> Bool
}

public enum Part1 {
    public static func totalWinnings(from input: String) -> Int {
        let hands = parseHands(from: input)
        return totalWinnings(from: hands)
    }

    static func totalWinnings(from hands: [Hand]) -> Int {
        let sortedHands = hands.sorted()
        var winnings = 0

        for (index, hand) in sortedHands.enumerated() {
            winnings += hand.bid * (index + 1)
        }

        return winnings
    }

    static func parseHands(from input: String) -> [Hand] {
        input
            .components(separatedBy: .newlines)
            .compactMap { parseHand(from: $0) }
    }

    static func parseHand(from input: String, Evaluator: HandEvaluator.Type = Evaluator.self) -> Hand? {
        let cardsAndBid = input.components(separatedBy: .whitespaces)

        let rawCards = cardsAndBid[0]
        let cards = mapToInt(rawCards)
        let type = handType(for: cards, Evaluator: Evaluator)
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

    private static func handType(for cards: [Int], Evaluator: HandEvaluator.Type) -> HandType {
        if Evaluator.handIsFiveOfAKind(cards) { return .fiveOfAKind }
        if Evaluator.handIsFourOfAKind(cards) { return .fourOfAKind }
        if Evaluator.handIsFullHouse(cards) { return .fullHouse }
        if Evaluator.handHasThreeOfAKind(cards) { return .threeOfAKind }
        if Evaluator.handIsTwoPair(cards) { return .twoPair }
        if Evaluator.handHasExactlyOnePair(cards) { return .onePair }
        return .highCard
    }

    enum Evaluator: HandEvaluator {
        static func handIsFiveOfAKind(_ cards: [Int]) -> Bool {
            cards.allSatisfy { $0 == cards[0] }
        }

        static func handIsFourOfAKind(_ cards: [Int]) -> Bool {
            maxEqualCards(in: cards) == 4
        }

        static func handIsFullHouse(_ cards: [Int]) -> Bool {
            handHasThreeOfAKind(cards) && handHasExactlyOnePair(cards)
        }

        static func handHasThreeOfAKind(_ cards: [Int]) -> Bool {
            maxEqualCards(in: cards) == 3
        }

        static func handIsTwoPair(_ cards: [Int]) -> Bool {
            numberOfPairs(in: cards) == 2
        }

        static func handHasExactlyOnePair(_ cards: [Int]) -> Bool {
            numberOfPairs(in: cards) == 1
        }

        private static func numberOfPairs(in cards: [Int]) -> Int {
            var pairedCardsCount = 0

            for card in cards {
                let equals = cards.filter { $0 == card }
                if equals.count == 2 {
                    pairedCardsCount += 1
                }
            }

            return (pairedCardsCount / 2)
        }

        static func maxEqualCards(in cards: [Int]) -> Int {
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
}

public enum Part2 {
    public static func totalWinnings(from input: String) -> Int {
        let hands = parseHands(from: input)
        return Part1.totalWinnings(from: hands)
    }

    static func parseHands(from input: String) -> [Hand] {
        input
            .components(separatedBy: .newlines)
            .compactMap { Part1.parseHand(from: $0, Evaluator: Evaluator.self) }
            .map {
                Hand(
                    type: $0.type,
                    cards: $0.cards.replacingElevensWithOnes(),
                    bid: $0.bid,
                    sortString: $0.sortString.replacingOccurrences(of: "W", with: "1")
                )
            }
    }

    enum Evaluator: HandEvaluator {
        static func handIsFiveOfAKind(_ cards: [Int]) -> Bool {
            let cardsWithoutJokers = cards.filter { $0 != 11 }
            return cardsWithoutJokers.allSatisfy { $0 == cardsWithoutJokers[0] }
        }
        
        static func handIsFourOfAKind(_ cards: [Int]) -> Bool {
            let cardsWithoutJokers = cards.filter { $0 != 11 }
            let numberOfJokers = cards.count - cardsWithoutJokers.count
            return Part1.Evaluator.maxEqualCards(in: cardsWithoutJokers) + numberOfJokers == 4
        }
        
        static func handIsFullHouse(_ cards: [Int]) -> Bool {
            let cardsWithoutJokers = cards.filter { $0 != 11 }
            let numberOfJokers = cards.count - cardsWithoutJokers.count
            let group1 = cardsWithoutJokers.filter { $0 == cardsWithoutJokers[0] }
            let group2 = cardsWithoutJokers.filter { $0 != cardsWithoutJokers[0] }
            guard group2.allSatisfy({ $0 == group2[0] }) else { return false }

            if group1.count == 3 && group2.count + numberOfJokers == 2 {
                return true
            }
            if group2.count == 3 && group1.count + numberOfJokers == 2 {
                return true
            }
            if group1.count == 2 && group2.count + numberOfJokers == 3 {
                return true
            }
            if group2.count == 2 && group1.count + numberOfJokers == 3 {
                return true
            }
            return false
        }
        
        static func handHasThreeOfAKind(_ cards: [Int]) -> Bool {
            let cardsWithoutJokers = cards.filter { $0 != 11 }
            let numberOfJokers = cards.count - cardsWithoutJokers.count
            return Part1.Evaluator.maxEqualCards(in: cardsWithoutJokers) + numberOfJokers == 3
        }
        
        static func handIsTwoPair(_ cards: [Int]) -> Bool {
            numberOfPairs(in: cards) == 2
        }
        
        static func handHasExactlyOnePair(_ cards: [Int]) -> Bool {
            numberOfPairs(in: cards) == 1
        }

        private static func numberOfPairs(in cards: [Int]) -> Int {
            let cardsWithoutJokers = cards.filter { $0 != 11 }
            var numberOfJokers = cards.count - cardsWithoutJokers.count

            var pairedCardsCount = 0

            for card in cardsWithoutJokers {
                let equals = cardsWithoutJokers.filter { $0 == card }
                if equals.count == 2 {
                    pairedCardsCount += 1
                } else if equals.count == 1 && numberOfJokers > 0 {
                    pairedCardsCount += 2
                    numberOfJokers -= 1
                }
            }

            return (pairedCardsCount / 2)
        }
    }
}

private extension Array where Element == Int {
    func replacingElevensWithOnes() -> Array {
        map { $0 == 11 ? 1 : $0 }
    }
}
