//
//  ContentView.swift
//  WordScramble
//
//  Created by 이지원 on 2022/07/25.
//

import SwiftUI

struct ContentView: View {
    /// 이미 사용한 단어 배열
    @State private var usedWords: [String] = []
    /// 다른 단어의 철자에 대한 루트 단어
    @State private var rootWord: String = ""
    /// 텍스트 필드에 바인딩할 수 있는 문자열
    @State private var newWord: String = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
        }
    }

    private func addNewWord() {
        let answer: String = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard !answer.isEmpty else {
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
