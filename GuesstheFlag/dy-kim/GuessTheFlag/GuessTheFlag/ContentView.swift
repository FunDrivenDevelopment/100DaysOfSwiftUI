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
    private let numberOfQuestions: Int

    @State private var conturies = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var answerIndex: Int

    var answerCountury: String { conturies[answerIndex] }

    @State private var showingScore = false
    @State private var showingGameSummary = false

    @State private var scoreTitle = ""
    @State private var totalScore: Int = 0
    @State private var gameStage: Int = 1

    init(numberOfOptions: Int = 3, numberOfQuestions: Int = 8) {
        self.numberOfOptions = numberOfOptions
        self.answerIndex = .random(in: 0..<numberOfOptions)
        self.numberOfQuestions = numberOfQuestions
    }

    var body: some View {
        ZStack {
            background

            VStack {
                Spacer()

                Text("Guess The Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())

                Spacer()

                content
                    .padding()

                Spacer()
                Spacer()

                scoreDisplay
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: renewQuestion)
        }
        .alert("Game Over", isPresented: $showingGameSummary) {
            Button("Finish", action: renewGame)
        } message: {
            Text("Your final score is \(totalScore)")
        }
    }

    var background: some View {
        RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.1),
            .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 1)
        ], center: .top, startRadius: 200, endRadius: 600)
            .ignoresSafeArea()
    }

    var content: some View {
        VStack(spacing: 20) {
            question
            flags
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }

    var scoreDisplay: some View {
        VStack {
            Text("Stage \(gameStage)/\(numberOfQuestions)")
                .font(.subheadline)

            Text("Score: \(totalScore)")
                .foregroundStyle(.primary)
                .font(.title2.bold())
        }
        .padding()
        .padding(.horizontal)
        .background(.thinMaterial)
        .clipShape(Capsule())
    }

    var question: some View {
        VStack() {
            Text("Tap the flag of")
                .font(.subheadline.weight(.heavy))

            Text(answerCountury)
                .font(.title.weight(.semibold))
        }
    }

    var flags: some View {
        ForEach(0..<numberOfOptions, id: \.self) { index in
            Button { flagTapped(index) } label: {
                FlagImage(conturies[index])
            }
        }
    }

    func flagTapped(_ index: Int) {
        let conturySelected = conturies[index]
        let isAnswerCorrect = conturySelected == answerCountury
        let isLastStage = gameStage == numberOfQuestions

        scoreTitle = isAnswerCorrect ? "Correct!" : "Wrong! That’s the flag of \(conturySelected)"
        totalScore += isAnswerCorrect ? scorePerAnswer : 0

        if (isLastStage) {
            showingGameSummary = true
        } else {
            showingScore = true
        }
    }

    var feedbackMessage: some View {
        Text("Your score is \(totalScore)")
    }

    func renewQuestion() {
        gameStage += 1
        conturies.shuffle()
        answerIndex = .random(in: 0...(numberOfOptions - 1))
    }

    func renewGame() {
        renewQuestion()
        totalScore = 0
        gameStage = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
