//
//  GridStack.swift
//  ViewsAndModifiers
//
//  Created by 이지원 on 2022/07/16.
//

import SwiftUI

// View 프로토콜을 채택하는 제네릭인데, 들어올 수 있는 값도 View 임
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}
