//
//  AddView.swift
//  iExpense
//
//  Created by 이지원 on 2022/08/10.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
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
            .toolbar {
                Button("Save") {
                    let item: ExpenseItem = ExpenseItem(
                        name: name, type: type, amount: amount
                    )
                    expenses.items.append(item)
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
