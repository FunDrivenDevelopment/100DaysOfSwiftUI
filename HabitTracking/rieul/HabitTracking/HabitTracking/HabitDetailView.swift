//
//  HabitDetailView.swift
//  HabitTracking
//
//  Created by 이지원 on 2022/10/01.
//

import SwiftUI

struct HabitDetailView: View {
    @State private var count: Int = 0
    @ObservedObject private var habitListViewModel: HabitListViewModel

    private let habit: Habit

    init(habit: Habit, habitListViewModel: HabitListViewModel) {
        self.habit = habit
        self.habitListViewModel = habitListViewModel
    }

    var body: some View {
        Form {
            Text(habit.title)
            Text(habit.description)

            Section {
                Stepper("\(count)", value: $count, in: 0...Int.max)
            } header: {
                Text("Count")
            }
        }
        .onAppear {
            self.count = habit.count
        }
        .onDisappear {
            update()
        }
    }

    private func update() {
        let newHabit = Habit(
            id: habit.id,
            title: habit.title,
            description: habit.description,
            count: self.count
        )
        habitListViewModel.modify(newHabit)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habit: Habit.sampleHabits[0], habitListViewModel: HabitListViewModel())
    }
}
