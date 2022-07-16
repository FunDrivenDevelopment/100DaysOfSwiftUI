//
//  LargeBlueTitle.swift
//  ViewsAndModifiers
//
//  Created by 이지원 on 2022/07/16.
//

import SwiftUI

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
    }
}

extension View {
    func largeBlueTitle() -> some View {
        modifier(LargeBlueTitle())
    }
}
