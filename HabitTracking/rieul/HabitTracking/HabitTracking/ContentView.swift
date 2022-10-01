//
//  ContentView.swift
//  HabitTracking
//
//  Created by 이지원 on 2022/10/01.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: HabitListViewModel = .init()
    @State private var isPresentingSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.habits) { habit in
                    NavigationLink {
                        HabitDetailView(
                            habit: habit,
                            habitListViewModel: viewModel
                        )
                    } label: {
                        Text(habit.title)
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem {
                    Button {
                        isPresentingSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingSheet) {
                NewHabitView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
