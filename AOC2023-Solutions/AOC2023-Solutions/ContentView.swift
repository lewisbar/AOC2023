//
//  ContentView.swift
//  AOC2023-Solutions
//
//  Created by LennartWisbar on 01.12.23.
//

import SwiftUI
import AOC2023_Day1

struct ContentView: View {
    private var day1Part1: String {
        let input = Day1Input.input
        if let result = Day1.Part1.calibrationSum(in: input) {
            return String(result)
        }
        return "No solution"
    }

    private var day1Part2: String {
        let input = Day1Input.input
        if let result = Day1.Part2.calibrationSum(in: input) {
            return String(result)
        }
        return "No solution"
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Day 1")
                .font(.title)
            
            HStack {
                Text("Part 1:")
                Text(day1Part1)
            }
            HStack {
                Text("Part 2:")
                Text(day1Part2)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
