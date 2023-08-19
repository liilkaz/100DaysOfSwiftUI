//
//  CustomPaths.swift
//  Drawing
//
//  Created by Лилия Феодотова on 18.08.2023.
//

import SwiftUI

struct CustomPaths: View {
    let title = "Creating custom paths with SwiftUI"
    
    func path() -> Path {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            path.closeSubpath()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 230) {
                path().fill(.blue)
                path().stroke(.blue, lineWidth: 10)
                path().stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            }
        }
        .navigationTitle(title)
    }
}

struct CustomPaths_Previews: PreviewProvider {
    static var previews: some View {
        CustomPaths()
    }
}
