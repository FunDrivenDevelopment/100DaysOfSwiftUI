//
//  AddView.swift
//  iExpense
//
//  Created by 김대영 on 2022/08/29.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = 0.0

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: self.$name)

                Picker("Type", selection: self.$type) {
                    ForEach(ExpenseType.allCases) { type in
                        Text(type.rawValue.capitalized)
                    }
                }

                TextField("Amount", value: self.$amount, format: .currency(code: "USD"))
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Add") {
                    let item = ExpenseItem(
                        name: self.name,
                        type: self.type,
                        amount: self.amount
                    )

                    self.expenses.items.append(item)
                    self.dismiss()
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
