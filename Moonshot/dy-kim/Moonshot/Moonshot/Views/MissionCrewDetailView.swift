//
//  MissionCrewDetailView.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/23.
//

import SwiftUI

struct MissionCrewDetailView: View {
    let missionCrew: MissionCrew

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(self.missionCrew.id)
                    .resizable()
                    .scaledToFit()

                Text(self.missionCrew.description)
                    .padding()
            }
            .padding(.vertical)
        }
        .navigationTitle(self.missionCrew.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MissionCrewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCrewDetailView(missionCrew: missionCrews[1])
    }
}
