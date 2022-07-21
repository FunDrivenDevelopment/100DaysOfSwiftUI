//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by HyeJee Kim on 2022/07/11.
//

import SwiftUI

struct ContentView: View {
    private let maxQuizCount: Int = 8
    
    @State private var showingScoreAlert: Bool = false
    @State private var scoreAlertTitle: String = ""
    
    @State private var showingFinishAlert: Bool = false
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var score: Int = 0
    @State private var selectedIndex: Int = 0
    @State private var quizCount: Int = 0 {
        didSet {
            if quizCount == maxQuizCount {
                showingFinishAlert = true
            }
            else {
                showingFinishAlert = false
            }
        }
    }
    
    var isCorrect: Bool {
        correctAnswer == selectedIndex
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        //                    .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
    
                Spacer()
                Spacer()
                
                Text("Score: \(score)/\(maxQuizCount)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreAlertTitle, isPresented: $showingScoreAlert) {
            Button("Continue", action: continueQuiz)
        } message: {
            generateScoreAlertMessage()
        }
        .alert("Done!", isPresented: $showingFinishAlert) {
            Button("Reset", action: resetAll)
        } message: {
            Text("You've got \(score) out of \(maxQuizCount)")
        }
    }
    
    func flagTapped(_ index: Int) {
        selectedIndex = index
        
        if isCorrect {
            scoreAlertTitle = "Correct"
            score += 1
        }
        else {
            scoreAlertTitle = "Wrong"
        }
        
        showingScoreAlert = true
    }
    
    func continueQuiz() {
        if quizCount + 1 <= maxQuizCount {
            quizCount += 1
        }
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func generateScoreAlertMessage() -> Text {
        if isCorrect {
            return Text("Your score is \(score)")
        }
        else {
            return Text("Wrong! That's the flag of \(countries[selectedIndex])")
        }
    }
    
    func resetAll() {
        score = 0
        quizCount = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
