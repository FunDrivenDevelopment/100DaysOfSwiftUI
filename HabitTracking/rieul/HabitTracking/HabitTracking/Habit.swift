//
//  Habit.swift
//  HabitTracking
//
//  Created by 이지원 on 2022/10/01.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    var count: Int = 0
}

extension Habit {
    static let sampleHabits: [Habit] = [
        .init(title: "독서", description: "책 5분 읽기"),
        .init(title: "운동", description: "30분 달리기")
    ]
}

