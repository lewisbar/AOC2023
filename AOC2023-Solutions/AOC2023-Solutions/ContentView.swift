//
//  ContentView.swift
//  AOC2023-Solutions
//
//  Created by LennartWisbar on 01.12.23.
//

import SwiftUI
import AOC2023_Day1

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(Day1Input.input.calibrationSum ?? 0)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
