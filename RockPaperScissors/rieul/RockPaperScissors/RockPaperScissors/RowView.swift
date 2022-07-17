//
//  RowView.swift
//  RockPaperScissors
//
//  Created by 이지원 on 2022/07/17.
//

import SwiftUI

struct RowView: View {
    let leadingText: String
    let trailingText: String

    var body: some View {
        HStack {
            Text(leadingText)
            Spacer()
            Text(trailingText)
        }
    }
}
