//
//  DaySummaryView.swift
//  AOC2023-Solutions
//
//  Created by LennartWisbar on 03.12.23.
//

import SwiftUI

struct DaySummaryView: View {
    let day: String
    let solution1: String
    let solution2: String

    var body: some View {
        VStack(spacing: 16) {
            Text("Day \(day)")
                .font(.title)

            HStack {
                Text("Part 1:")
                Text(solution1)
            }
            HStack {
                Text("Part 2:")
                Text(solution2)
            }
        }
        .padding()
    }
}
