//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by 이지원 on 2022/07/16.
//

import SwiftUI

extension Image {
    func flagImage() -> some View {
        self
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
