//
//  ContentView.swift
//  BetterRest
//
//  Created by 이지원 on 2022/07/16.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Double = 8.0

    var body: some View {
        Stepper(
            "\(sleepAmount.formatted()) hours",
            value: $sleepAmount,
            in: 4...12,
            step: 0.25
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
