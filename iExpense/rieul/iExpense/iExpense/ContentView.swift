//
//  ContentView.swift
//  iExpense
//
//  Created by 이지원 on 2022/08/09.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName: String = "Bilbo"
    @Published var lastName: String = "Baggins"
}

struct ContentView: View {
    @StateObject var user: User = User()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
