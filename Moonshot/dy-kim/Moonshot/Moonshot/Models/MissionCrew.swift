//
//  MissionCrew.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/23.
//

import Foundation

struct MissionCrew: Identifiable {
    let id: String
    let name: String
    let role: String
    let description: String
}

let missionCrews = missions[0].crew.map {
    Mission.missionCrews(crew: $0, astronauts: astronauts)
}
