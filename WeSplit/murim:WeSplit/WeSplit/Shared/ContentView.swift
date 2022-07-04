//
//  ContentView.swift
//  Shared
//
//  Created by TOBO WORLD on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
    @State var tapCount = 0
    
    var body: some View {
           Button("Tap Count: \(tapCount)") {
               self.tapCount = tapCount  + 1
           }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
