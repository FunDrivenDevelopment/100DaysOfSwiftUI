//
//  CrewRole.swift
//  Moonshot
//
//  Created by 이지원 on 2022/08/14.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
