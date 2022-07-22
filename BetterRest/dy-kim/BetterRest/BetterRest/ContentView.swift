//
//  ContentView.swift
//  BetterRest
//
//  Created by 김대영 on 2022/07/21.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount: Double = 8
    @State private var coffeeAmount: Int = 2

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 0) {
            Form {
                desiredWakeTime
                desiredSleepAmountSection
                coffeeAmountSection
            }
            calculateButton
        }
        .ignoresSafeArea(edges: .bottom)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("알겠어요") { }
        } message: {
            Text(alertMessage)
        }
    }

    var desiredWakeTime: some View {
        HStack {
            Text("언제 일어나고 싶으신가요?")
                .font(.headline)

            Spacer()

            DatePicker("일어나고 싶은 시간을 선택해주세요", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
    }

    var desiredSleepAmountSection: some View {
        Section {
            Stepper("\(sleepAmount.formatted()) 시간", value: $sleepAmount, in: 4...12, step: 0.25)
        } header: {
            Text("희망 수면 시간")
                .font(.headline).foregroundColor(.primary)
        }
    }

    var coffeeAmountSection: some View {
        Section {
            Stepper("\(coffeeAmount.formatted()) 컵", value: $coffeeAmount, in: 1...20)
        } header: {
            Text("하루에 커피 몇 잔을 드시나요?")
                .font(.headline).foregroundColor(.primary)
        }
    }

    var calculateButton: some View {
        Button(action: calculateBedtime) {
            Text("취침 시각 계산")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity)
                .padding(20)
                .padding(.bottom)
                .background(.primary)
        }
    }

    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try BedtimeCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let bedTime = wakeUp - prediction.actualSleep

            alertTitle = "추천 취침 시간을 알려드려요"
            alertMessage = bedTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "에러!"
            alertMessage = "취침 시각 계산 도중에 에러가 발생했어요."
        }

        showingAlert = true
    }
}

var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? Date.now
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
