//
//  Move.swift
//  Rock Paper Scissors
//
//  Created by Yeonu Yi on 17/07/2022.
//

import Foundation

enum Move: CaseIterable {
    case rock
    case paper
    case scissors

    var icon: String {
        switch self {
        case .rock:
            return "👊"
        case .paper:
            return "✋"
        case .scissors:
            return "✌️"
        }
    }

    var winTo: Move {
        switch self {
        case .rock:
            return .scissors
        case .paper:
            return .rock
        case .scissors:
            return .paper
        }
    }

    var loseTo: Move {
        switch self {
        case .rock:
            return .paper
        case .paper:
            return .scissors
        case .scissors:
            return .rock
        }
    }
}
