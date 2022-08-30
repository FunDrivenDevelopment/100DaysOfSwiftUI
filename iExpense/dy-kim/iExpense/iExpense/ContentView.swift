//
//  ContentView.swift
//  iExpense
//
//  Created by 김대영 on 2022/08/29.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var isPresentingAddView = false

    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(self.expenses.personalItems) {
                        ItemRowView(item: $0)
                    }
                    .onDelete { self.removeItems(at: $0, on: .personal) }
                }

                Section("Business") {
                    ForEach(self.expenses.businessItems) {
                        ItemRowView(item: $0)
                    }
                    .onDelete { self.removeItems(at: $0, on: .business) }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    self.isPresentingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: self.$isPresentingAddView) {
            AddView(expenses: self.expenses)
        }
    }

    func removeItems(at offsets: IndexSet, on type: ExpenseType) {
        switch type {
        case .business:
            offsets.forEach {
                self.expenses.items.remove(at: self.expenses.indexOfBusinessItems[$0])
            }
        case .personal:
            offsets.forEach {
                self.expenses.items.remove(at: self.expenses.indexOfPersonalItems[$0])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
