//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 이지원 on 2022/07/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("왕왕 큰 파랑색 타이틀")
                .largeBlueTitle()
            GridStack(rows: 4, columns: 4) { row, column in
                Image(systemName: "\(row * 4 + column).circle")
                Text("R\(row) C\(column)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
