//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by 김대영 on 2022/07/15.
//

import SwiftUI

struct FlagImage: View {
    let image: String
    let state: FlagState

    init(_ image: String, state: FlagState = .initial) {
        self.image = image
        self.state = state
    }

    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .rotation3DEffect(.degrees(self.state == .tapped ? 360 : 0),
                              axis: (0, 1, 0))
            .opacity(self.state == .notTapped ? 0.25 : 1)
            .scaleEffect(self.state == .notTapped ? 0.75 : 1)
            .animation(.spring(), value: state)
    }
}

enum FlagState {
    case initial, tapped, notTapped
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage("France")
    }
}
