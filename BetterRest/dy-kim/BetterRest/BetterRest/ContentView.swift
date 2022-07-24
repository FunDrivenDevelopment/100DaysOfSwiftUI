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
    @State private var coffeeAmount: Int = 3

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var getCoffeeAmountWithPicker = false
    @State private var autoCalculation = false

    private var bedTimeString: String {
        guard let bedTime = calculateBedtime() else {
            return "Error!"
        }

        return bedTime.formatted(date: .omitted, time: .shortened)
    }
    private let coffeeAmountRange = 0...20

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    desiredWakeTime
                    desiredSleepAmountSection
                    coffeeAmountSection
                    Toggle("자동 계산", isOn: $autoCalculation)
                }

                if autoCalculation {
                    bedTimeView
                } else {
                    calculateButton
                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("알겠어요") { }
            } message: {
                Text(alertMessage)
            }
            .navigationTitle("언제 자야할까?")
        }
    }

    var desiredWakeTime: some View {
        HStack {
            Text("언제 일어나고 싶으신가요?")
                .font(.headline)
                .padding(.vertical)

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
            if getCoffeeAmountWithPicker {
                Picker("커피 얼마나?", selection: $coffeeAmount) {
                    ForEach(coffeeAmountRange, id: \.self) {
                        Text("\($0) 잔")
                    }
                }.pickerStyle(.wheel)
            } else {
                Stepper("\(coffeeAmount.formatted()) 컵", value: $coffeeAmount, in: coffeeAmountRange)
            }
        } header: {
            Text("하루에 커피 몇 잔을 드시나요?")
                .font(.headline).foregroundColor(.primary)
        } footer: {
            Toggle("Use Picker?", isOn: $getCoffeeAmountWithPicker)
                .toggleStyle(UnobtrusiveToggleStyle())
                .font(.headline)
        }
    }

    var bedTimeView: some View {
        VStack {
            Text("추천 취침 시각")
                .foregroundStyle(.thickMaterial)

            Text(bedTimeString)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
        .ignoresSafeArea(edges: .bottom)
        .background(.indigo)
    }

    var calculateButton: some View {
        Button(action: showBedTime) {
            Text("취침 시각 계산")
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity)
                .padding(.top, 30)
                .background(.primary)
        }
        .foregroundColor(.indigo)
    }

    func showBedTime() {
        guard let bedTime = calculateBedtime() else {
            alertTitle = "에러!"
            alertMessage = "취침 시각 계산 도중에 에러가 발생했어요."
            showingAlert = true

            return
        }

        alertTitle = "추천 취침 시간을 알려드려요"
        alertMessage = bedTime.formatted(date: .omitted, time: .shortened)
        showingAlert = true
    }

    func calculateBedtime() -> Date? {
        var bedTime: Date? = Date()

        do {
            let config = MLModelConfiguration()
            let model = try BedtimeCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            bedTime = wakeUp - prediction.actualSleep
        } catch {
            bedTime = nil
        }
        return bedTime
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UnobtrusiveToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Spacer()

            configuration.label.padding(5)

            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .accentColor : .gray)
                .font(.headline.weight(.heavy))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
