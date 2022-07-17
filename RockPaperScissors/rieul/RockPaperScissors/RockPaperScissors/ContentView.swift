//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by 이지원 on 2022/07/17.
//

import SwiftUI

struct ContentView: View {
    private let handShapes: [HandShape] = [Rock(), Paper(), Scissors()]
    private let maxOfGames: Int = 10
    @State private var answer: Int = Int.random(in: 0...2)
    @State private var shouldWin: Bool = Bool.random()
    @State private var score: Int = 0
    @State private var numberOfGames: Int = 0
    @State private var isEnd: Bool = false

    var body: some View {
        VStack {
            Text("플레이어의 점수: \(score)")
                .padding()

            Text("앱의 움직임: \(handShapes[answer].name)")
                .padding()

            Text("앱을 이겨야 하나요?: \(shouldWin ? "네" : "아니오")")
                .padding()

            ForEach(handShapes, id: \.name) { handShape in
                Button(handShape.name) {
                    calculateScore(for: handShape)
                }
                .padding()
            }
        }
        .alert("게임 종료!", isPresented: $isEnd) {
            Button("다시 하기", action: reset)
        } message: {
            Text("최종 점수: \(score)")
        }
    }

    func calculateScore(for selected: HandShape) {
        if shouldWin {
            if handShapes[answer].lose == type(of: selected) {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if handShapes[answer].win == type(of: selected) {
                score += 1
            } else {
                score -= 1
            }
        }
        answer = Int.random(in: 0...2)
        shouldWin.toggle()
        numberOfGames += 1
        if numberOfGames == maxOfGames {
            isEnd = true
        }
    }

    func reset() {
        answer = Int.random(in: 0...2)
        shouldWin = Bool.random()
        numberOfGames = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
