//
//  MissionView.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/15.
//

import SwiftUI

struct MissionDetailView: View {
    let mission: Mission

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
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(self.mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        MissionDetailView(mission: missions[0])
    }
}
