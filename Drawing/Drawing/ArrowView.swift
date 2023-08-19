//
//  ArrowView.swift
//  Drawing
//
//  Created by Лилия Феодотова on 19.08.2023.
//

import SwiftUI

struct Arrow: Shape {
    var height: Double
    var width: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(height, width) }
        set {
            width = newValue.first
            height = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let height = rect.height * height
        let thickness = rect.width * width / 2
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: height))
        path.addLine(to: CGPoint(x: rect.maxX, y: height))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        
        path.move(to: CGPoint(x: rect.midX, y: height))
        path.addLine(to: CGPoint(x: rect.midX + thickness, y: height))
        path.addLine(to: CGPoint(x: rect.midX + thickness, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - thickness, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - thickness, y: height))
        
        path.closeSubpath()

        return path
    }
}

struct ArrowView: View {
    @State private var height = 0.5
    @State private var width = 0.5
    
    var body: some View {
        Arrow(height: height, width: width)
            .fill(.secondary)
            .padding()
            .onTapGesture {
                withAnimation {
                    height = 0.3
                    width = 0.3
                }
            }.ignoresSafeArea(edges: .bottom)
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
