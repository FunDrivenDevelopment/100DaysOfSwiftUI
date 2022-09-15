//
//  ContentView.swift
//  Moonshot
//
//  Created by 김대영 on 2022/09/01.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: self.columns) {
                    ForEach(missions) { mission in
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
                .padding(.top)
            }
            .navigationTitle("Moonshots")
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
