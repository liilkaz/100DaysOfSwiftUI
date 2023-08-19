//
//  SpecialEffectsView.swift
//  Drawing
//
//  Created by Лилия Феодотова on 18.08.2023.
//

import SwiftUI

struct SpecialEffectsView: View {
    @State private var amountBlend = 0.0
    @State private var amountBlur = 0.0
    
    var body: some View {
        Form {
            Section("Multiplay") {
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 200)
                    .colorMultiply(.red)
            }
            Section("Blending") {
                VStack {
                    ZStack {
                        Circle()
                            .fill(.red)
                            .frame(width: 200 * amountBlend)
                            .offset(x: -50, y: -80)
                            .blendMode(.screen)
                
                        Circle()
                            .fill(.green)
                            .frame(width: 200 * amountBlend)
                            .offset(x: 50, y: -80)
                            .blendMode(.screen)
                
                        Circle()
                            .fill(.blue)
                            .frame(width: 200 * amountBlend)
                            .blendMode(.screen)
                        }
                    .frame(width: 300, height: 300)
                    Slider(value: $amountBlend)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .ignoresSafeArea()
            }
            Section("Blur") {
                VStack {
                    Image("Example")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 200)
                        .saturation(amountBlur)
                        .blur(radius: (1 - amountBlur) * 20)
                    Slider(value: $amountBlur)
                    .padding()}
            }
        }
        

        
    }
}

struct SpecialEffectsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectsView()
    }
}
