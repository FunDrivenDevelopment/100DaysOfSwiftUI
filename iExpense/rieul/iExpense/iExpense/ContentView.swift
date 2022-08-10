//
//  ContentView.swift
//  iExpense
//
//  Created by 이지원 on 2022/08/09.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @StateObject var expenses: Expenses = Expenses()
    @State private var showingAddExpense: Bool = false

    var body: some View {
        NavigationView {
            List {
                personalList

                businessList
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    var personalList: some View {
        Section {
            ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }

                    Spacer()
                    Text(
                        item.amount,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .foregroundColor(color(amount: item.amount))
                }
            }
            .onDelete { removeItems(at: $0, in: "Personal") }
        } header: {
            Text("Personal")
        }
    }

    var businessList: some View {
        Section {
            ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }

                    Spacer()
                    Text(
                        item.amount,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .foregroundColor(color(amount: item.amount))
                }
            }
            .onDelete { removeItems(at: $0, in: "Business") }
        } header: {
            Text("Business")
        }
    }

    // TODO: Section 에 맞는 인덱스
    func removeItems(at offsets: IndexSet, in type: String) {
//        let findIndex: Int = expenses.items.filter { $0.type == type }
//            .index(after: Int(offsets.first ?? 0))
//        expenses.items.remove(at: findIndex)
        for offset in offsets {
            print(offset)
        }
    }

    func color(amount: Double) -> Color {
        if amount < 10.0 {
            return .black
        } else if amount < 100.0 {
            return .blue
        } else {
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
