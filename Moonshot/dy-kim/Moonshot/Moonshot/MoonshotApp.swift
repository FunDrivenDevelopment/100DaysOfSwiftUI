//
//  MoonshotApp.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/01.
//

import SwiftUI

@main
struct MoonshotApp: App {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some Scene {
        WindowGroup {
            ContentView(
                astronauts: self.astronauts,
                missions: self.missions
            )
        }
    }
}
