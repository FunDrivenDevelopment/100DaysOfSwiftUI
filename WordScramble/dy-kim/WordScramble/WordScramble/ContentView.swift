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

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

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
            .toolbar {
                ToolbarItem {
                    Button {
                        startGame()
                        usedWords = []
                        newWord = ""
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.headline.bold())
                            .padding()
                    }
                }
            }
        }
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }

    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be original!")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make it up!")
            return
        }

        guard isLongEnough(word: answer) else {
            wordError(title: "Word too short", message: "Word must be at least three letters!")
            return
        }

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

    func wordError(title: String, message: String) {
        self.errorTitle = title
        self.errorMessage = message
        self.showingError = true
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word) && word != rootWord
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misSpelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misSpelledRange.location == NSNotFound
    }

    func isLongEnough(word: String) -> Bool {
        return word.count >= 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
