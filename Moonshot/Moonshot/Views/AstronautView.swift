//
//  AstronautView.swift
//  Moonshot
//
//  Created by Лилия Феодотова on 04.08.2023.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronauts

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronauts] = Bundle.main.decode("astronauts.json")

        static var previews: some View {
            AstronautView(astronaut: astronauts["aldrin"]!)
                .preferredColorScheme(.dark)
        }
}
