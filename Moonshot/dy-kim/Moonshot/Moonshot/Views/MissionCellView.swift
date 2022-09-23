//
//  MissionCellView.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/23.
//

import SwiftUI

struct MissionCellView: View {
    let mission: Mission

    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .padding(10)

            VStack {
                Text(mission.displayName)
                    .font(.headline)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct MissionCellView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCellView(mission: missions[0])
            .frame(width: 150, height: 250)
    }
}
