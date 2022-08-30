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
    @State private var currencyCode: String = "KRW"

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: self.$name)

                Picker("Type", selection: self.$type) {
                    ForEach(ExpenseType.allCases) { type in
                        Text(type.rawValue.capitalized)
                    }
                }

                Section {
                    Picker("Currency Code", selection: self.$currencyCode) {
                        ForEach(Locale.isoCurrencyCodes, id: \.self) { code in
                            VStack(alignment: .leading) {
                                let localizedCurrencyCode = Locale.current.localizedString(forCurrencyCode: code) ?? ""

                                Text(code)
                                Text(localizedCurrencyCode)
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .tag(code)
                        }
                    }

                    // ISSUE: self.currencyCode 변경 되어도 TextField의 포맷이 바뀌지 않음
                    // TextField("Amount", value: self.$amount, format: .currency(code: self.currencyCode))

                    TextField("Amount", value: self.$amount, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Add") {
                    let item = ExpenseItem(
                        name: self.name,
                        type: self.type,
                        amount: self.amount,
                        currencyCode: self.currencyCode
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
