//
//  MissionView.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/15.
//

import SwiftUI

struct MissionDetailView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: proxy.size.width * 0.5)

                    VStack(alignment: .leading) {
                        Text(self.mission.displayName)
                            .font(.title.bold())
                            .padding(.bottom)

                        Text(self.mission.description)
                    }
                    .padding()

                    MissionCrewListView(crews: self.missionCrews)
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(self.mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }

    var missionCrews: [MissionCrew] {
        self.mission.crew.map {
            Mission.missionCrews(crew: $0, astronauts: self.astronauts)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDetailView(
            mission: missions[0],
            astronauts: astronauts
        )
    }
}
