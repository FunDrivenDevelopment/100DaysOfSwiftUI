//
//  ContentView.swift
//  Shared
//
//  Created by TOBO WORLD on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
    @State var name = ""

       var body: some View {
           Form {
               TextField("Enter your name", text: $name)
               Text("Hello, world!")\    Text("Your name is \(name)")
           }
       
       }
    
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
