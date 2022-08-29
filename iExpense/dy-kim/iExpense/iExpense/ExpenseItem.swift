//
//  ExpenseItem.swift
//  iExpense
//
//  Created by 김대영 on 2022/08/29.
//

import Foundation

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

enum ExpenseType: String, CaseIterable, Codable, Identifiable {
    case business, personal

    var id: Self { self }
}
