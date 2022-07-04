//
//  ContentView.swift
//  WeSplit
//
//  Created by 이지원 on 2022/06/30.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    private let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    private var total: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return tipValue + checkAmount
    }
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    @FocusState private var amountIsFocused: Bool
    private let currencyFormatter: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currencyCode ?? "USD")
                    )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id:\.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How much top do you want to leave?")
                }

                Section {
                    Text(totalPerPerson, format: currencyFormatter)
                } header: {
                    Text("Amount per person")
                }

                Section {
                    Text(total, format: currencyFormatter)
                } header: {
                    Text("Total")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
