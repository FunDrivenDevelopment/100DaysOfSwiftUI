//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Yeonu Yi on 17/07/2022.
//

import SwiftUI

struct ContentView: View {
    private let moves = Move.allCases
    private let playLimit = 3

    @State private var currentChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var currentPlay = 0

    var body: some View {
        VStack(spacing: 10) {
            Text("😺's move")
                .font(.largeTitle)
            Text(moves[currentChoice].icon)
                .font(.largeTitle)
                .padding(.bottom, 30)
            Text("You need to \(shouldWin ? "win" : "lose")")
            Text("What's your move?")
                .padding(.bottom, 30)
            ForEach(moves, id: \.self) { move in
                Button(move.icon) {
                    buttonPressed(selectedMove: move)
                }
                .font(.system(size: 35))
                .padding()
                .background(Color.pink)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            Text("Your score is \(score)")
                .padding(.top, 35)
                .font(.title2)
            if currentPlay == playLimit {
                Button("Restart") {
                    currentPlay = 0
                    score = 0
                }
            }
        }
    }

    func buttonPressed(selectedMove: Move) {
        guard currentPlay < playLimit else { return }
        if shouldWin {
            score = selectedMove.winTo ==  moves[currentChoice] ? score + 1 : score - 1
        } else {
            score = selectedMove.loseTo == moves[currentChoice] ? score + 1 : score - 1
        }
        currentChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        currentPlay += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
