//
//  ContentView.swift
//  iExpense
//
//  Created by 이지원 on 2022/08/09.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    let id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = []
}

struct ContentView: View {
    @StateObject var expenses: Expenses = Expenses()

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    let expense: ExpenseItem = ExpenseItem(
                        name: "Test", type: "Personal", amount: 5
                    )
                    expenses.items.append(expense)
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
