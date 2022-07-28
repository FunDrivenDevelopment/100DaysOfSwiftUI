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
    /// 에러 타이틀
    @State private var errorTitle: String = ""
    /// 에러 메시지
    @State private var errorMessage: String = ""
    /// 에러 표시 여부
    @State private var showingError: Bool = false

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
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }

    private func addNewWord() {
        let answer: String = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard !answer.isEmpty else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard !isShort(word: answer) else {
            wordError(title: "너무 짧음", message: "3글자 이하는 허용하지 않습니다.")
            return
        }

        guard !isStart(word: answer) else {
            wordError(title: "시작 단어", message: "시작 단어는 허용하지 않습니다.")
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

    /// 단어가 이전에 사용되었는지 여부를 판별한다.
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    /// 임의의 단어로 rootWord를 만들 수 있는지 여부를 판별한다.
    private func isPossible(word: String) -> Bool {
        var tempWord: String = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    /// 실제로 있는 단어인지 판별한다.
    private func isReal(word: String) -> Bool {
        let checker: UITextChecker = UITextChecker()
        let range: NSRange = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange: NSRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        return misspelledRange.location == NSNotFound
    }

    private func isStart(word: String) -> Bool {
        return rootWord.hasPrefix(word)
    }

    private func isShort(word: String) -> Bool {
        return word.count < 3
    }

    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
