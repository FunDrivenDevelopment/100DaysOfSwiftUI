//
//  ContentView.swift
//  Converter
//
//  Created by TOBO WORLD on 2022/07/08.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit : Dimension = UnitLength.meters
    @State private var outputUnit : Dimension = UnitLength.kilometers
    @State private var selectedUnit = 0
    
    @FocusState private var inputIsFocused : Bool
    
    let conversions = ["Distance", "Mass","Temperature","Time"]
    
    let unitTypes = [
        [UnitLength.feet,UnitLength.kilometers,UnitLength.meters,UnitLength.miles,UnitLength.yards],
        [UnitMass.grams,UnitMass.kilograms,UnitMass.ounces,UnitMass.pounds],
        [UnitTemperature.celsius,UnitTemperature.fahrenheit,UnitTemperature.kelvin],
        [UnitDuration.hours,UnitDuration.minutes,UnitDuration.seconds]
    ]
    
    let formatter : MeasurementFormatter
    
    var result : String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurement)
    }
    

    var body: some View {
        NavigationView{
            Form{
                
                Section {
                    TextField("Amount",value : $input,format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }header: {
                    Text("Amount to convert")
                }
                
                Picker("Convert from", selection: $selectedUnit){
                    ForEach(0..<conversions.count){
                        Text(conversions[$0])
                    }
                }
                
                Picker("Convert from", selection: $inputUnit){
                    ForEach(unitTypes[selectedUnit], id : \.self){
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                Picker("Convert to", selection: $outputUnit){
                    ForEach(unitTypes[selectedUnit], id : \.self){
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
                Section{
                    Text(result)
                }header: {
                    Text("Result")
                }
            }
            .navigationTitle("Converter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnit) { newSelection in
                let units = unitTypes[newSelection]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        }
    }
    init(){
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
