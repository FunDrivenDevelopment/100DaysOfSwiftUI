//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by 김대영 on 2022/07/17.
//

import SwiftUI

enum RockPaperScissorsGame: String, CaseIterable {
    case Rock = "👊🏼"
    case Paper = "🖐🏼"
    case Scissors = "✌🏼"

    func willBeat() -> Self {
        switch self {
        case .Rock:
            return .Scissors
        case .Paper:
            return .Rock
        case .Scissors:
            return .Paper
        }
    }

    func willLose() -> Self {
        switch self {
        case .Rock:
            return .Paper
        case .Paper:
            return .Scissors
        case .Scissors:
            return .Rock
        }
    }

    static func chooseRandomly() -> Self {
        Self.allCases.randomElement() ?? .Rock
    }
}

enum gameGoal: String, CaseIterable {
    case Win = "Win"
    case Lose = "Lose"

    static func chooseRandomly() -> Self {
        Self.allCases.randomElement() ?? .Win
    }
}

struct ContentView: View {
    @State private var choice = RockPaperScissorsGame.chooseRandomly()
    @State private var goal = gameGoal.chooseRandomly()
    @State private var gameStage: Int = 1
    let numberOfStages: Int

    init(numberOfStages: Int = 10) {
        self.numberOfStages = numberOfStages
    }

    var body: some View {
        VStack {
            gameDirection

            HStack {
                ForEach(RockPaperScissorsGame.allCases, id: \.self) { sign in
                    buttonForRockPaperScissors(sign)
                }
            }
            .padding()
        }
    }

    var gameDirection: some View {
        Text("Play to \(goal.rawValue)")
            .font(.largeTitle)
    }

    func buttonForRockPaperScissors(_ sign: RockPaperScissorsGame) -> some View {
        Button {
            // Some Action
        } label: {
            Text(sign.rawValue)
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(Material.thin)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2)
        .padding(.horizontal, 3)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
