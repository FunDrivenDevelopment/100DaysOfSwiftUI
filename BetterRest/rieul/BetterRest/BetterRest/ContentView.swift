//
//  ContentView.swift
//  BetterRest
//
//  Created by 이지원 on 2022/07/16.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp: Date = defaultWakeTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1

    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false

    static var defaultWakeTime: Date {
        var components: DateComponents = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

    var body: some View {
        NavigationView {
            Form {
                wakeUpView

                sleepView

                coffeeView
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    var wakeUpView: some View {
        Section("When do you want to wake up?") {
            DatePicker(
                "Please enter a time",
                selection: $wakeUp,
                displayedComponents: .hourAndMinute
            )
                .labelsHidden()
        }
    }

    var sleepView: some View {
        Section("Desired amount of sleep") {
            Stepper(
                "\(sleepAmount.formatted()) hours",
                value: $sleepAmount,
                in: 4...12,
                step: 0.25
            )
        }
    }

    var coffeeView: some View {
        Section("Daily coffee intake") {
            Picker(
                coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                selection: $coffeeAmount
            ) {
                ForEach(0..<21) { coffee in
                    Text("\(coffee)")
                }
            }
        }
    }

    func calculateBedtime() {
        do {
            let config: MLModelConfiguration = MLModelConfiguration()
            let model: SleepCalculator = try SleepCalculator(configuration: config)

            let components: DateComponents = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp
            )
            let hour: Int = (components.hour ?? 0) * 60 * 60
            let minute: Int = (components.minute ?? 0) * 60

            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )

            let sleepTime: Date = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            showingAlert = true
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating you bedtime"
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
