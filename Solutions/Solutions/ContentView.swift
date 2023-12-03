//
//  ContentView.swift
//  Solutions
//
//  Created by LennartWisbar on 01.12.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ForEach(Solutions.daySummaries) { summary in
                DaySummaryView(day: summary.id, solution1: summary.solution1, solution2: summary.solution2)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    ContentView()
}
