//
//  StudyContentView.swift
//  MultiplicationTables
//
//  Created by Лилия Феодотова on 03.08.2023.
//

import SwiftUI

struct StudyContentView: View {
    @Binding var model: StartModels
    
    var body: some View {
        ZStack{
            Color(.orange).ignoresSafeArea()
            VStack{
                Text("Multiplication Table of \(model.chooseTable + 2)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .shadow(color: .black, radius: 1, x: 2, y: 1)
                
                Section {
                    ForEach(1..<13){num in
                        Text("\(model.chooseTable + 2) x \(num) = \((model.chooseTable + 2)*num)")
                    }
                    
                } .padding(10)
                    .background(.thinMaterial)
                    .font(.title2)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 3, x: 2, y: 3)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.black, lineWidth: 2)
                                            )
            }
        }
    }
}

struct StudyContentView_Previews: PreviewProvider {
    static private var model = Binding.constant(StartModels())
    
    static var previews: some View {
        StudyContentView(model: model)
    }
}
