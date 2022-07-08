//
//  ContentView.swift
//  Converter
//
//  Created by TOBO WORLD on 2022/07/08.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    
    @FocusState private var inputIsFocused : Bool
    
    let units : [UnitLength] = [.feet,.kilometers,.meters,.miles,.yards]
    
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
                
                Picker("Convert from", selection: $inputUnit){
                    ForEach(units, id : \.self){
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                Picker("Convert to", selection: $outputUnit){
                    ForEach(units, id : \.self){
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
