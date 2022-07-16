//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 이지원 on 2022/07/16.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText: Bool = false

    var body: some View {
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
