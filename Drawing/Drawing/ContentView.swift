//
//  ContentView.swift
//  Drawing
//
//  Created by Лилия Феодотова on 18.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    CustomPaths()
                } label: {Text(CustomPaths().title)}
                NavigationLink {
                    Shapes()
                } label: {
                    Text("Paths vs shapes in SwiftUI")
                }
                NavigationLink {
                    UseInsettableShape()
                } label: {
                    Text("Adding strokeBorder() support with InsettableShape")
                }
                NavigationLink {
                    FlowerView()
                } label: {
                    Text("Transforming shapes using CGAffineTransform and even-odd fills")
                }
                NavigationLink {
                    BordersView()
                } label: {
                    Text("Creative borders and fills using ImagePaint")
                }
                NavigationLink {
                    ColorCyclingCircleView()
                } label: {
                    Text("Enabling high-performance Metal rendering with drawingGroup()")
                }
                NavigationLink {
                    SpecialEffectsView()
                } label: {
                    Text("Special effects in SwiftUI: blurs, blending, and more")
                }
                NavigationLink {
                    TrapezoidView()
                } label: {
                    Text("Animating simple shapes with animatableData")
                }
                NavigationLink {
                    CheckerboardView()
                } label: {
                    Text("Animating complex shapes with AnimatablePair")
                }
                NavigationLink {
                    SpirographView()
                } label: {
                    Text("Creating a spirograph with SwiftUI")
                }
            }
            .navigationBarTitle("DRAWINGS")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
