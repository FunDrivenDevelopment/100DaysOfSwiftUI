//
//  ContentView.swift
//  Shared
//
//  Created by TOBO WORLD on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
       var body: some View {
           TipPercent()
       }
}

struct TipPercent : View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                        .pickerStyle(.segmented)
                    }
            }
            Section {
                Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
            } header: {
                Text("How much tip do you want to leave?")
            }
        }
    }
}

struct SelectPeople : View {
    
    var body: some View {
        NavigationView {
      
                
        }.navigationTitle("WeSplit")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
