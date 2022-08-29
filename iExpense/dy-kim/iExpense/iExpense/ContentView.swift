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
                ForEach(self.expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type.rawValue.capitalized)
                        }

                        Spacer()

                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: self.removeItems)
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

    func removeItems(at offsets: IndexSet) {
        self.expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
