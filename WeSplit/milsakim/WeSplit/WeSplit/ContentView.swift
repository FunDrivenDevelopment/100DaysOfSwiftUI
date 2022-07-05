//
//  ContentView.swift
//  WeSplit
//
//  Created by HyeJee Kim on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Int = 20
    
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount: Double = Double(numberOfPeople + 2)
        let tipSelection: Double = Double(tipPercentage)
        
        let tipValue: Double = checkAmount * tipSelection / 100
        let grandTotal: Double = checkAmount + tipValue
        let totalPerPerson: Double = grandTotal / peopleCount
        
        return totalPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
