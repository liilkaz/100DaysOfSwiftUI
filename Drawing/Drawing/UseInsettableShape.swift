//
//  UseInsettableShape.swift
//  Drawing
//
//  Created by Лилия Феодотова on 18.08.2023.
//

import SwiftUI

struct Arc2: InsettableShape {
    var insetAmount = 0.0
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct UseInsettableShape: View {
    var body: some View {
        VStack (spacing: 50) {
            Circle()
                .strokeBorder(.blue, lineWidth: 40)
            Arc2(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
                .strokeBorder(.blue, lineWidth: 40)
                    
            }
        .padding()
        .navigationTitle("Adding strokeBorder() support with InsettableShape")
        
    }
}

struct UseInsettableShape_Previews: PreviewProvider {
    static var previews: some View {
        UseInsettableShape()
    }
}
