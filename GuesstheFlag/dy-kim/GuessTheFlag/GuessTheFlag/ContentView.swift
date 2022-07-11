//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 김대영 on 2022/07/11.
//

import SwiftUI

struct ContentView: View {
    private let numberOfOptions: Int
    private let scorePerAnswer: Int = 100

    @State private var conturies = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private  var answerIndex: Int

    var answerCountury: String { conturies[answerIndex] }

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore: Int = 0

    init(numberOfOptions: Int = 3) {
        self.numberOfOptions = numberOfOptions
        self.answerIndex = .random(in: 0...numberOfOptions)
    }

    var body: some View {
        ZStack {
            background

            VStack {
                question
                flags
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: renewQuestion)
        } message: {
            Text("Your score is \(totalScore)")
        }
    }

    var background: some View {
        Color.brown
            .ignoresSafeArea()
    }

    var question: some View {
        VStack {
            Text("Tap the flag of")
            Text(answerCountury)
        }
    }

    var flags: some View {
        ForEach(0..<numberOfOptions, id: \.self) { index in
            Button { flagTapped(index) } label: {
                Image(conturies[index])
                    .renderingMode(.original)
            }
        }
    }

    func flagTapped(_ index: Int) {
        if conturies[index] == answerCountury {
            scoreTitle = "Correct!"
            totalScore += scorePerAnswer
        } else {
            scoreTitle = "Wrong!"
        }

        showingScore = true
    }

    func renewQuestion() {
        conturies.shuffle()
        answerIndex = .random(in: 0...numberOfOptions)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
