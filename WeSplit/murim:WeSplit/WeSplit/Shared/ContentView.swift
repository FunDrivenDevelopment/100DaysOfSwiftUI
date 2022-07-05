//
//  ContentView.swift
//  Shared
//
//  Created by TOBO WORLD on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount : Double = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage : Int = 20
    
    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue : Double = checkAmount / 100 * Double(tipPercentage)
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    
       var body: some View {
           NavigationView {
               Form {
                   Section{
                       TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                               .keyboardType(.decimalPad)
                               .focused($amountIsFocused)

                           Picker("Number of people", selection: $tipPercentage) {
                               ForEach(2 ..< 100) {
                                   Text("\($0) people")
                               }
                               .pickerStyle(.segmented)
                           }
                   }header: {
                       Text("How much tip do you want to leave?")
                   }
                   Section {
                       Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                   }
                   thirdSection()
               }
               .navigationTitle("We Split")
               .toolbar{
                   ToolbarItemGroup(placement: .keyboard) {
                       Spacer()
                       Button("Done"){
                           amountIsFocused = false
                       }
                   }
               }
           }
       }
}

struct thirdSection : View {
   
    var body: some View {
        Section {
            anotherView()
        } header: {
            Text("Amount per person")
        }
    }
}

struct anotherView : View {
    @State var selectPercent = 0
    
    var body: some View {
        Picker("tip percentage", selection: $selectPercent) {
            ForEach(0..<101) {
                Text("\($0) %")
            }
        }
        .pickerStyle(.wheel)
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
