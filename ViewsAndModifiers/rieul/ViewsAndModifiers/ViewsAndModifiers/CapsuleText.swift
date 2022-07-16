//
//  CapsuleText.swift
//  ViewsAndModifiers
//
//  Created by 이지원 on 2022/07/16.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
//            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}
