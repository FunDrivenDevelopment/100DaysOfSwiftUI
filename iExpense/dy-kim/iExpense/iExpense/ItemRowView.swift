//
//  ItemRowView.swift
//  iExpense
//
//  Created by 김대영 on 2022/08/30.
//

import SwiftUI

struct ItemRowView: View {
    let item: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.rawValue.capitalized)
            }

            Spacer()

            Text(item.amount, format: .currency(code: item.currencyCode))
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(
            item: ExpenseItem(
                id: .init(),
                name: "Lunch",
                type: .personal,
                amount: 15000,
                currencyCode: "KRW"
            )
        )
    }
}
