//
//  MissionCrewListView.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/23.
//

import SwiftUI

struct MissionCrewListView: View {
    let crews: [MissionCrew]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(self.crews) { crew in
                    NavigationLink(destination: MissionCrewDetailView(missionCrew: crew)) {
                        MissionCrewCellView(crew: crew)
                    }
                }
            }
        }
    }
}

struct MissionCrewCellView: View {
    let crew: MissionCrew

    var body: some View {
        HStack {
            Image(crew.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.thickMaterial, lineWidth: 2)
                }

            VStack(alignment: .leading, spacing: 5) {
                Text(crew.name)
                    .font(.headline.bold())
                    .foregroundStyle(.primary)

                Text(crew.role)
                    .foregroundStyle(.secondary)
            }
            .foregroundColor(.white)
        }
        .padding(.horizontal)
    }
}

struct MissionCrewListView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCrewListView(crews: missionCrews)
            .preferredColorScheme(.dark)
    }
}
