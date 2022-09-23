//
//  ContentView.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/01.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: self.columns) {
                    ForEach(missions) { mission in
                        NavigationLink(destination: MissionDetailView(
                            mission: mission,
                            astronauts: self.astronauts
                        )) {
                            MissionCellView(mission: mission)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Moonshots")
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            astronauts: astronauts,
            missions: missions
        )
    }
}
