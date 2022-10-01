//
//  HabitListViewModel.swift
//  HabitTracking
//
//  Created by 이지원 on 2022/10/01.
//

import Foundation
import Combine

final class HabitListViewModel: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet {
            store.save(self.habits)
        }
    }

    init() {
        self.habits = store.load() ?? []
    }

    private let store: UserDefaultStore = UserDefaultStore()

    func save(_ habit: Habit) {
        habits.append(habit)
    }

    func modify(_ habit: Habit) {
        if let index: Int = habits.firstIndex(where: {habit.id == $0.id}) {
            habits[index] = habit
        }
    }
}

final class UserDefaultStore {
    static let key: String = "Habits"

    func save(_ habits: [Habit]) {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultStore.key)
        }
    }

    func load() -> [Habit]? {
        guard
            let data = UserDefaults.standard.data(forKey: UserDefaultStore.key),
            let decoded = try? JSONDecoder().decode([Habit].self, from: data)
        else {
            return nil
        }

        return decoded
    }
}
