//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by 김대영 on 2022/07/15.
//

import SwiftUI

struct FlagImage: View {
    let image: String

    init(_ image: String) {
        self.image = image
    }

    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage("France")
    }
}
