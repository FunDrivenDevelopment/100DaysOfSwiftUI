//
//  ContentView.swift
//  Shared
//
//  Created by TOBO WORLD on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Form{
            Group{
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
            }
            Group{
                Text("Hello, world!").padding()
                Text("Hello, world!").padding()
                Text("Hello, world!").padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
