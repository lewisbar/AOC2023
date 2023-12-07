//
//  Day7Tests.swift
//  Day7Tests
//
//  Created by LennartWisbar on 07.12.23.
//

import XCTest
@testable import Day7

final class Day7Tests: XCTestCase {
    func test_parseHand_returnsHand() {
        let input = [
            "AKQJT 123",
            "11234 234",
            "11233 345",
            "12333 456",
            "11122 567",
            "12222 678",
            "11111 789"
        ]

        let result = input.map(Part1.parseHand)

        let expectedHands = [
            Hand(type: .highCard, cards: [14, 13, 12, 11, 10], bid: 123, sortString: "ZYXWV"),
            Hand(type: .onePair, cards: [1, 1, 2, 3, 4], bid: 234, sortString: "11234"),
            Hand(type: .twoPair, cards: [1, 1, 2, 3, 3], bid: 345, sortString: "11233"),
            Hand(type: .threeOfAKind, cards: [1, 2, 3, 3, 3], bid: 456, sortString: "12333"),
            Hand(type: .fullHouse, cards: [1, 1, 1, 2, 2], bid: 567, sortString: "11122"),
            Hand(type: .fourOfAKind, cards: [1, 2, 2, 2, 2], bid: 678, sortString: "12222"),
            Hand(type: .fiveOfAKind, cards: [1, 1, 1, 1, 1], bid: 789, sortString: "11111")
        ]

        XCTAssertEqual(result, expectedHands)
    }

    func test_parseHands_returnsListOfHands() {
        let input = """
        AKQJT 123
        11234 234
        11233 345
        12333 456
        11122 567
        12222 678
        11111 789
        """

        let result = Part1.parseHands(from: input)

        let expectedHands = [
            Hand(type: .highCard, cards: [14, 13, 12, 11, 10], bid: 123, sortString: "ZYXWV"),
            Hand(type: .onePair, cards: [1, 1, 2, 3, 4], bid: 234, sortString: "11234"),
            Hand(type: .twoPair, cards: [1, 1, 2, 3, 3], bid: 345, sortString: "11233"),
            Hand(type: .threeOfAKind, cards: [1, 2, 3, 3, 3], bid: 456, sortString: "12333"),
            Hand(type: .fullHouse, cards: [1, 1, 1, 2, 2], bid: 567, sortString: "11122"),
            Hand(type: .fourOfAKind, cards: [1, 2, 2, 2, 2], bid: 678, sortString: "12222"),
            Hand(type: .fiveOfAKind, cards: [1, 1, 1, 1, 1], bid: 789, sortString: "11111")
        ]

        XCTAssertEqual(result, expectedHands)
    }

    func test_sortHands_returnsWeakestHandsFirst() {
        let input = [
            Hand(type: .twoPair, cards: [13, 10, 11, 11, 10], bid: 220, sortString: "YVWWV"),
            Hand(type: .onePair, cards: [3, 2, 10, 3, 13], bid: 765, sortString: "32V3Y"),
            Hand(type: .threeOfAKind, cards: [10, 5, 5, 11, 5], bid: 684, sortString: "V55W5"),
            Hand(type: .fullHouse, cards: [12, 12, 12, 11, 14], bid: 567, sortString: "XXXWZ"),
            Hand(type: .twoPair, cards: [13, 13, 6, 7, 7], bid: 28, sortString: "YY677")
        ]

        let result = input.sorted()

        let expectedResult = [
            Hand(type: .onePair, cards: [3, 2, 10, 3, 13], bid: 765, sortString: "32V3Y"),
            Hand(type: .twoPair, cards: [13, 10, 11, 11, 10], bid: 220, sortString: "YVWWV"),
            Hand(type: .twoPair, cards: [13, 13, 6, 7, 7], bid: 28, sortString: "YY677"),
            Hand(type: .threeOfAKind, cards: [10, 5, 5, 11, 5], bid: 684, sortString: "V55W5"),
            Hand(type: .fullHouse, cards: [12, 12, 12, 11, 14], bid: 567, sortString: "XXXWZ")
        ]

        XCTAssertEqual(result, expectedResult)
    }

    func test_totalWinnings_returnsSolution() {
        let input = [
            Hand(type: .twoPair, cards: [13, 10, 11, 11, 10], bid: 220, sortString: "YVWWV"),
            Hand(type: .onePair, cards: [3, 2, 10, 3, 13], bid: 765, sortString: "32V3Y"),
            Hand(type: .threeOfAKind, cards: [10, 5, 5, 11, 5], bid: 684, sortString: "V55W5"),
            Hand(type: .threeOfAKind, cards: [12, 12, 12, 11, 14], bid: 483, sortString: "XXXWZ"),
            Hand(type: .twoPair, cards: [13, 13, 6, 7, 7], bid: 28, sortString: "YY677")
        ]

        let result = Part1.totalWinnings(from: input)

        XCTAssertEqual(result, 6440)
    }

    func test_totalWinningsFromInput_returnsSolution() {
        let input = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

        let result = Part1.totalWinnings(from: input)

        XCTAssertEqual(result, 6440)
    }
}
