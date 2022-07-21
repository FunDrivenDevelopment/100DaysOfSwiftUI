//
//  ContentView.swift
//  BetterRest
//
//  Created by 김대영 on 2022/07/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount: Double = 8
    @State private var coffeeAmount = 2

    var body: some View {
        VStack {
            Text("언제 일어나고 싶으신가요?")
                .font(.headline)

            DatePicker("일어나고 싶은 시간을 선택해주세요", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()

            Text("희망 수면 시간")
                .font(.headline)

            Stepper("\(sleepAmount.formatted()) 시간", value: $sleepAmount, in: 4...12, step: 0.25)

            Text("하루에 커피 몇 잔을 드시나요?")
                .font(.headline)

            Stepper("\(coffeeAmount.formatted()) 컵", value: $coffeeAmount, in: 1...20)

            Spacer()

            Button(action: calculateBedtime) {
                Text("취침 시각 계산")
            }
        }
    }

    func calculateBedtime() {
//        return Date.now
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
