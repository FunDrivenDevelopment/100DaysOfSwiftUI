//
//  AddView.swift
//  iExpense
//
//  Created by 이지원 on 2022/08/10.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expense: Expenses
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0

    let types: [String] = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expense: Expenses())
    }
}
