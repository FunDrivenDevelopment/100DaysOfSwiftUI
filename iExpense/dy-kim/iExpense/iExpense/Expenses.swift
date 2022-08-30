//
//  Expenses.swift
//  iExpense
//
//  Created by 김대영 on 2022/08/29.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let data = try? JSONEncoder().encode(self.items) {
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }

    init() {
        guard let data = UserDefaults.standard.data(forKey: "Items") else {
            self.items = []
            return
        }

        if let items = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
            self.items = items
        }
    }

    var indexOfPersonalItems: [Int] {
        self.items.enumerated().compactMap { (index, element) -> Int? in
            element.type == .personal ? index : nil
        }
    }

    var indexOfBusinessItems: [Int] {
        self.items.enumerated().compactMap { (index, element) -> Int? in
            element.type == .business ? index : nil
        }
    }

    var personalItems: [ExpenseItem] {
        self.items.filter { $0.type == .personal }
    }

    var businessItems: [ExpenseItem] {
        self.items.filter { $0.type == .business }
    }
}
