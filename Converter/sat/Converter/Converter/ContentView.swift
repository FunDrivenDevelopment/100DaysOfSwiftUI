//
//  ContentView.swift
//  Converter
//
//  Created by Yeonu Yi on 06/07/2022.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Declaration

    private enum Unit {
        case celsius(value: Double)
        case fahrenheit(value: Double)
        case kelvin(value: Double)

        init(unit: String, value: Double) {
            if unit == "Celsius" {
                self = .celsius(value: value)
            } else if unit == "Fahrenheit" {
                self = .fahrenheit(value: value)
            } else {
                self = .kelvin(value: value)
            }
        }

        var toCelsius: Double {
            switch self {
            case .celsius(let value):
                return value
            case .fahrenheit(let value):
                return (value - 32) * 5/9
            case .kelvin(let value):
                return value - 273.15
            }
        }

        var toFahrenheit: Double {
            switch self {
            case .celsius(let value):
                return (value * 9/5) + 32
            case .fahrenheit(let value):
                return value
            case .kelvin(let value):
                return (value - 273.15) * 9/5 + 32
            }
        }

        var toKelvin: Double {
            switch self {
            case .celsius(let value):
                return value + 273.15
            case .fahrenheit(let value):
                return (value - 32) * 5/9 + 273.15
            case .kelvin(let value):
                return value
            }
        }
    }

    // MARK: - Properties

    private let units = ["Celsius", "Fahrenheit", "Kelvin"]

    @State private var fromUnit: String = "Celsius"
    @State private var toUnit: String = "Fahrenheit"
    @State private var fromValue: Double = 0.0

    private var toValue: Double {
        let from = Unit(unit: fromUnit, value: fromValue)

        if toUnit == "Celsius" {
            return from.toCelsius
        } else if toUnit == "Fahrenheit" {
            return from.toFahrenheit
        } else {
            return from.toKelvin
        }
    }

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
                    Text(toValue, format: .number)

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
