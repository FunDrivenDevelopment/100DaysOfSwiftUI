//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by HyeJee Kim on 2022/07/21.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitle() -> some View {
        modifier(ProminentTitle())
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    @State private var useRedText: Bool = false
    
    let motto1: Text = Text("Motto 1")
    let motto2: Text = Text("Motto 2")
    
    var body: some View {
        VStack {
            motto1
                .foregroundColor(.red)
            motto1
                .prominentTitle()
            motto2
                .foregroundColor(.blue)
            CapsuleText(text: "Test")
                .font(Font.body)
            CapsuleText(text: "Test 2")
                .font(.caption)
                .foregroundColor(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
