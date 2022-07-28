//
//  ContentView.swift
//  WordScramble
//
//  Created by 김대영 on 2022/07/28.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord = ""
    @State private var newWord = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Type new word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
            }
            .navigationTitle(rootWord)
        }
        .onAppear(perform: startGame)
    }

    func startGame() {
        // Read start.txt
        // Pick random word and assign it to the rootWord
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"

                return
            }
        }

        fatalError("Can not load 'start.txt' file from bundle!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
