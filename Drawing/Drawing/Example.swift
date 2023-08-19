//
//  Example.swift
//  Drawing
//
//  Created by Лилия Феодотова on 19.08.2023.
//

import SwiftUI


struct Example<Content: View>: View {
    @ViewBuilder let content: Content
    let title: String
    
    var body: some View {
        content
            .ignoresSafeArea()
            .navigationTitle(title)
    }
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example(content: {
            BordersView()
        }, title: "BordersView")
    }
}
