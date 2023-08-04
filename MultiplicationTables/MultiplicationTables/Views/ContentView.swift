//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Лилия Феодотова on 02.08.2023.
//

import SwiftUI

struct ContentView: View {    
    @State private var model = StartModels()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                VStack(alignment: .center, spacing: 40) {
                    Text("Multiplication Table")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    VStack {
                        Section("Table of \(model.chooseTable + 2)") {
                            Picker("", selection: $model.chooseTable) {
                                ForEach (2..<13) {
                                    Text("\($0)")
                                }
                            }
                            .padding(10)
                            .frame(height: 50)
                            .background(.yellow)
                            .cornerRadius(15)
                            .shadow(color: .black, radius: 3, x: 2, y: 3)
                            .overlay(RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.black, lineWidth: 2))
                        }.pickerStyle(.segmented)
                        
                        Section("Question's count") {
                            Stepper("\(model.numberOfQuestions.formatted()) questions", value: $model.numberOfQuestions, in: 5...20, step: 5)
                                .padding(10)
                                .foregroundColor(.black)
                                .font(.title3)
                                .frame(height: 50)
                                .background(.yellow)
                                .cornerRadius(15)
                                .shadow(color: .black, radius: 3, x: 2, y: 3)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(.black, lineWidth: 2))
                        }
                    } .foregroundColor(.white)
                        .font(.title)
                    
                    Spacer()
                    
                    NavigationLink {
                        StartContentView(model: $model)
                    } label: {
                        Text("Start!")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 40)
                            .background(.red)
                            .cornerRadius(20)
                            .shadow(color: .black, radius: 3, x: 2, y: 3)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(.black, lineWidth: 4)
                                                    )
                    }
                    
                    NavigationLink {
                        StudyContentView(model: $model)
                    } label: {
                        Text("Study!")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 40)
                            .background(.green)
                            .cornerRadius(20)
                            .shadow(color: .black, radius: 3, x: 2, y: 3)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(.black, lineWidth: 4)
                                                    )
                            
                    }
                    Spacer()
                }.padding(20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
