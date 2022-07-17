//
//  HandShape.swift
//  RockPaperScissors
//
//  Created by 이지원 on 2022/07/17.
//

import Foundation

protocol HandShape {
    var name: String { get }
    var win: HandShape.Type { get }
    var compare: HandShape.Type { get }
    var lose: HandShape.Type { get }
}

extension HandShape {
    var compare: HandShape.Type { Self.self }
}

struct Rock: HandShape {
    var name: String = "✊ Rock"

    var win: HandShape.Type { Scissors.self }
    var lose: HandShape.Type { Paper.self }
}

struct Paper: HandShape {
    var name: String = "🖐 Paper"

    var win: HandShape.Type { Rock.self }
    var lose: HandShape.Type { Scissors.self }
}

struct Scissors: HandShape {
    var name: String = "✌️ Scissors"

    var win: HandShape.Type { Paper.self }
    var lose: HandShape.Type { Rock.self }
}
