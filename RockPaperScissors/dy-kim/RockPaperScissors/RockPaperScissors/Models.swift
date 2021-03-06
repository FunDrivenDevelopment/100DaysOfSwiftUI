//
//  Models.swift
//  RockPaperScissors
//
//  Created by κΉλμ on 2022/07/20.
//

import Foundation

enum RockPaperScissorsGame: String, CaseIterable {
    case Rock = "ππΌ"
    case Paper = "ππΌ"
    case Scissors = "βπΌ"

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

enum GameGoal: String, CaseIterable {
    case Win = "Win"
    case Lose = "Lose"

    static func chooseRandomly() -> Self {
        Self.allCases.randomElement() ?? .Win
    }
}
