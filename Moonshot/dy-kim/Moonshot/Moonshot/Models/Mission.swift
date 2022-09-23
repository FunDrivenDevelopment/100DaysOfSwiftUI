//
//  Mission.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/15.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [Crew]
    let description: String

    struct Crew: Codable {
        let name: String
        let role: String
    }
}

extension Mission {
    var displayName: String {
        "Apollo \(self.id)"
    }

    var image: String {
        "apollo\(self.id)"
    }

    var formattedLaunchDate: String {
        self.launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }

    static func missionCrews(crew: Mission.Crew, astronauts: [String: Astronaut]) -> MissionCrew {
        if let astronaut = astronauts[crew.name] {
            return MissionCrew(
                id: crew.name,
                name: astronaut.name,
                role: crew.role,
                description: astronaut.description
            )
        } else {
            fatalError("No astronaut wit id: \(crew.name)")
        }
    }
}

let missions: [Mission] = Bundle.main.decode("missions.json")
