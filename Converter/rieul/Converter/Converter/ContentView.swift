//
//  ContentView.swift
//  Converter
//
//  Created by 이지원 on 2022/07/05.
//

import SwiftUI

struct ContentView: View {
    private let units: [String] = ["Second", "Minute", "Hour"]
    @State private var selectedBeforeUnit: String = "Second"
    @State private var selectedAfterUnit: String = "Second"
    @State private var input: Int = 0
    private var result: Double {
        if selectedBeforeUnit == selectedAfterUnit {
            return Double(input)
        }

        if selectedBeforeUnit == "Second" {
            if selectedAfterUnit == "Minute" {
                return Double(input) / 60.0
            } else {
                return Double(input) / 3600.0
            }
        } else if selectedBeforeUnit == "Minute" {
            if selectedAfterUnit == "Second" {
                return Double(input) * 60.0
            } else {
                return Double(input) / 60.0
            }
        } else {
            if selectedAfterUnit == "Second" {
                return Double(input) * 3600.0
            } else {
                return Double(input) * 60.0
            }
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("변환 단위", selection: $selectedBeforeUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)

                    TextField(selectedBeforeUnit, value: $input, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Before")
                }

                Section {
                    Picker("변환할 단위", selection: $selectedAfterUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(result, format: .number)
                } header: {
                    Text("After")
                }
            }
            .navigationTitle("시간 변환")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
