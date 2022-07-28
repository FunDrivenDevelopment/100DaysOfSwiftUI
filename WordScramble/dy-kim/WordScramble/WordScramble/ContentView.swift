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
    @State private var usedWords = [String]()

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Type new word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }

                Section {
                    ForEach(usedWords, id: \.self) {
                        Label($0, systemImage: "\($0.count).circle")
                    }
                }
            }
            .onSubmit(addNewWord)
            .navigationTitle(rootWord)
        }
        .onAppear(perform: startGame)
    }

    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard answer.count > 0 else { return }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        newWord = ""
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
