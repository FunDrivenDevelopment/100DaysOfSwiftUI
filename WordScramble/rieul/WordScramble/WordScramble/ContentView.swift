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
            .onAppear(perform: startGame)
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

    private func startGame() {
        // 1. app bundle 에서 start.txt 파일의 URL 찾기
        if let startWordsURL: URL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. start.txt 를 string 으로 불러오기
            if let startWords: String = try? String(contentsOf: startWordsURL) {
                // 3. 줄바꿈 단위로 문자열을 배열로 나누기
                let allWords: [String] = startWords.components(separatedBy: "\n")

                // 4. 무작위 단어 고르기, 없다면 "silkworm" 으로 대체
                rootWord = allWords.randomElement() ?? "silkworm"

                // 모든 작업이 끝났다면 종료
                return
            }
        }

        // 문제가 생겼다면 여기서 앱이 충돌나고 에러를 표시
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
