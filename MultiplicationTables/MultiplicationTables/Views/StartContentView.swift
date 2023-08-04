//
//  StartContentView.swift
//  MultiplicationTables
//
//  Created by Лилия Феодотова on 03.08.2023.
//

import SwiftUI

struct StartContentView: View {
    @Binding var model: StartModels
    
    @State private var scaleButton = 0.0
    
    var body: some View {
        ZStack{
            Color(.yellow)
                .ignoresSafeArea()
            VStack(spacing: 50) {
                Text("\(model.score)/\(model.numberOfQuestions)").font(.title2).fontWeight(.bold)
                Spacer()
                Image(systemName: model.isRight ? "checkmark" : "xmark")
                    .font(.system(size: 50))
                    .frame(width: 50, height: 50)
                    .background(model.isRight ? .green : .red)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.black, lineWidth: 1)
                    )
                    .scaleEffect(scaleButton)
                    .animation(.easeInOut.speed(0.2), value: scaleButton)
                Text(model.question)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)
                    .background(.orange)
                    .cornerRadius(20)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.black, lineWidth: 2)
                                            )
                Spacer()
                HStack{
                    ForEach(0..<4){ num in
                        Button{
                            model.checkAnswer(userAnswer: num)
                            withAnimation {
                                scaleButton += 5
                            }
                            scaleButton -= 5
                        }label: {
                            Text(String(model.variableOfAnswer[num]))
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .frame(width: 75, height: 75)
                                .background(.green)
                                .cornerRadius(20)
                                .shadow(color: .black, radius: 2, x: 2, y: 2)
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(.black, lineWidth: 2))
                        }
                    }
                }
                Spacer()
            }
            .onAppear {
                model.makeQuestion()
                
            }
            .alert("Your score: ", isPresented: $model.showAlert) {
                Button("Play again!") {
                    
                }
            } message: {
                Text("\(model.score)/\(model.numberOfQuestions)")
            }
        }
    }
    
    
}

struct StartContentView_Previews: PreviewProvider {
    static private var model = Binding.constant(StartModels())

    static var previews: some View {
        StartContentView(model: model)
    }
}
