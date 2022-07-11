//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by HyeJee Kim on 2022/07/11.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScoreAlert: Bool = false
    @State private var scoreAlertTitle: String = ""
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                }
            }
            
            .alert(scoreAlertTitle, isPresented: $showingScoreAlert) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is ???")
            }
        }
        
    }
    
    func flagTapped(_ index: Int) {
        if index == correctAnswer {
            print("correct")
            scoreAlertTitle = "Correct"
        }
        else {
            print("wrong")
            scoreAlertTitle = "Wrong"
        }
        
        showingScoreAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
