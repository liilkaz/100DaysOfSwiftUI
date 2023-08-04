//
//  ContentView.swift
//  Animations
//
//  Created by Лилия Феодотова on 31.07.2023.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount1 = 1.0
    @State private var animationAmount2 = 1.0
    @State private var animationAmount3 = 1.0
    @State private var animationAmount4 = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello SwiftUI")
    @State private var enabled2 = false
    @State private var dragAmount2 = CGSize.zero
    @State private var isShowingRed = false
    @State private var isShowingRed2 = false
    
    var body: some View {
        VStack {
            Form {
                Section("Anumation 1") {
                    Button("Tap Me") {
                         animationAmount1 += 1
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .scaleEffect(animationAmount1)
                    .animation(.default, value: animationAmount1)
                    .blur(radius: (animationAmount1 - 1) * 3)
                    .frame(height: 150)
                }
                Section("Anumation 2"){
                    Button("Tap Me") {
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.red)
                            .scaleEffect(animationAmount2)
                            .opacity(2 - animationAmount2)
                            .animation(
                                .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                                value: animationAmount2
                            )
                    )
                    .onAppear {
                        animationAmount2 = 2
                    }
                    .frame(height: 250)
                }
                Section("Anumation 3") {
                    Stepper("Scale amount", value: $animationAmount3.animation(), in: 1...10)
                    Button("Tap Me") {
                        animationAmount3 += 1
                    }
                    .padding(40)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .scaleEffect(animationAmount3)
                    .frame(height: 250)
                }
                Section("Animation 4") {
                    Button("Tap Me") {
                        withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                            animationAmount4 += 360
                        }
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .rotation3DEffect(.degrees(animationAmount4), axis: (x: 0, y: 1, z: 0))
                    .frame(height: 150)
                }
                Section("Animation 5") {
                    Button("Tap Me") {
                        enabled.toggle()
                    }
                    .frame(width: 200, height: 200)
                    .background(enabled ? .blue : .red)
                    .animation(nil, value: enabled)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                    .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
                }
                Section("Animation 6")  {
                    LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .offset(dragAmount)
                        .gesture(
                            DragGesture()
                                .onChanged { dragAmount = $0.translation }
                                .onEnded { _ in
                                    dragAmount = .zero
                                }
                        )
                        .frame(height: 300)
                }
                Section("Animation 7") {
                    HStack(spacing: 0) {
                        ForEach(0..<letters.count, id: \.self) { num in
                            Text(String(letters[num]))
                                .padding(5)
                                .font(.title)
                                .background(enabled2 ? .blue : .red)
                                .offset(dragAmount2)
                                .animation(.default.delay(Double(num) / 20), value: dragAmount2)
                        }
                    }.frame(height: 200)
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount2 = $0.translation }
                            .onEnded { _ in
                                dragAmount2 = .zero
                                enabled2.toggle()
                            }
                    )
                }
                Section("Animation 8") {
                    VStack{
                        Button("Tap Me") {
                            withAnimation {
                                isShowingRed.toggle()
                            }
                        }
                        if isShowingRed {
                            Rectangle()
                                .fill(.red)
                                .frame(width: 200, height: 200)
                                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        }
                    }
                    .frame(height: 350)
                }
                Section("Animation 9") {
                    ZStack {
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 200, height: 200)

                        if isShowingRed2 {
                            Rectangle()
                                .fill(.red)
                                .frame(width: 200, height: 200)
                                .transition(.pivot)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            isShowingRed2.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
