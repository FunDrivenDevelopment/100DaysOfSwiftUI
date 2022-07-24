//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by 김대영 on 2022/07/17.
//

import SwiftUI

struct ContentView: View {
    @State private var choice = RockPaperScissorsGame.chooseRandomly()
    @State private var goal = GameGoal.chooseRandomly()
    @State private var gameStage: Int = 1
    @State private var showingScore = false
    @State private var score: Int = 0

    let numberOfStages: Int

    init(numberOfStages: Int = 10) {
        self.numberOfStages = numberOfStages
    }

    var body: some View {
        VStack {
            Spacer()

            Text("Round \(gameStage)/\(numberOfStages)")
            gameDirection

            Spacer()
            Spacer()

            buttons

            Spacer()
        }
        .alert("Game Summary", isPresented: $showingScore) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your score is \(score)")
        }
    }

    var gameDirection: some View {
        Text("Play to \(goal.rawValue) \(choice.rawValue)")
            .font(.largeTitle.bold())
    }

    var buttons: some View {
        VStack {
            ForEach(RockPaperScissorsGame.allCases, id: \.self) { sign in
                buttonForRockPaperScissors(sign)
                    .padding(3)
            }
        }
        .padding()
    }

    func buttonForRockPaperScissors(_ sign: RockPaperScissorsGame) -> some View {
        Button {
            buttonTapped(scoreEarned: grade(sign, answer(choice, goal)))
        } label: {
            Text(sign.rawValue)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .background(Material.thin)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 2)
        }
    }

    func grade(_ sign: RockPaperScissorsGame, _ answer: RockPaperScissorsGame) -> Int {
        return sign == answer ? 1 : 0
    }

    func answer(_ choice: RockPaperScissorsGame, _ goal: GameGoal) -> RockPaperScissorsGame {
        switch goal {
        case .Win:  return choice.willLose()
        case .Lose: return choice.willBeat()
        }
    }

    func buttonTapped(scoreEarned: Int) {
        choice = RockPaperScissorsGame.chooseRandomly()
        goal = GameGoal.chooseRandomly()
        score += scoreEarned

        if gameStage == numberOfStages {
            showingScore = true
        } else {
            gameStage += 1
        }
    }

    func resetGame() {
        gameStage = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
