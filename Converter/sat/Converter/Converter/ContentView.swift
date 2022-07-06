//
//  ContentView.swift
//  Converter
//
//  Created by Yeonu Yi on 06/07/2022.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Properties

    private let units = ["Celsius", "Fahrenheit", "Kelvin"]

    @State private var fromUnit: String = "Celsius"
    @State private var toUnit: String = "Fahrenheit"
    @State private var fromValue: Double = 0.0
    @State private var toValue: Double = 0.0

    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("From", value: $fromValue, format: .number)
                        .keyboardType(.decimalPad)

                    Picker("Unit", selection: $fromUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }

                Image(systemName: "arrow.up.arrow.down")
                    .font(Font.system(.largeTitle))
                    .frame(maxWidth: .infinity, alignment: .center)

                Section {
                    TextField("To", value: $toValue, format: .number)
                        .keyboardType(.decimalPad)

                    Picker("Unit", selection: $toUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
            }
            .navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
