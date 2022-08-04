//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by TOBO WORLD on 2022/07/17.
//

import SwiftUI

struct ContentView: View {
    @State var useRedText = false
    @State var selectPercent = false
    
    var nestingView: some View {
        Text("Hello, world!")
            .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
    }
    
    var toggleView : some View {
        Button("change Text Color"){
            useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
    
    var wesplitConditional: some View {
        Picker("tip percentage", selection: $selectPercent) {
            ForEach(0..<101) {
                Text("\($0) %")
                    .foregroundColor($0 == 0 ? .red : .blue )
            }
        }
        .pickerStyle(.wheel)
    }
    
    var body: some View {
        toggleView
        wesplitConditional
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
