//
//  UnitConverterView.swift
//  Converter
//
//  Created by 김대영 on 2022/07/05.
//

import SwiftUI

struct TemperatureConverterView: View {
    @State private var temperature: Double = 0
    @State private var temperatureInputUnit: UnitTemperature = .celsius
    @State private var temperatureOutputUnit: UnitTemperature = .fahrenheit

    let temperatureUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]

    private var temperatureConverted: Measurement<UnitTemperature> {
        let input = Measurement(value: temperature, unit: temperatureInputUnit)
        let output = input.converted(to: temperatureOutputUnit)
        return output
    }

    var formatter: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        return formatter
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Temperature", value: $temperature, format: .number)
                } header: {
                    Text("Input").font(.headline)
                }

                Section {
                    Picker("Input Unit", selection: $temperatureInputUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color(.secondarySystemBackground))
                } header: {
                    Text("Input Unit")
                }

                Section {
                    Text(formatter.string(from: temperatureConverted))
                } header: {
                    Text("Output").font(.headline)
                }

                Section {
                    Picker("Output Unit", selection: $temperatureOutputUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color(.secondarySystemBackground))
                } header: {
                    Text("Output Unit")
                }
            }
            .navigationTitle("Temperature 🔃")
        }
    }
}

struct UnitConverterView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConverterView()
    }
}
