//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Лилия Феодотова on 17.07.2023.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct FlagImage: View {
    var countrie: String
    
    var body: some View {
        Image(countrie)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
        }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var endGame = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfQuestion = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .yellow, location: 0.2),
                .init(color: .purple, location: 0.4),
                .init(color: .black, location: 0.8)
            ], center: .center, startRadius: 0, endRadius: 500).ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                        .titleStyle()
                VStack(spacing: 18) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .titleStyle()
                            .fontWeight(.semibold)
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countrie: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score: \(score)")
        }
        .alert(scoreTitle, isPresented: $endGame) {
            Button("Restart") {
                askQuestion()
                score = 0
            }
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        showingScore = true
        numberOfQuestion += 1
    }
    
    func askQuestion() {
        if numberOfQuestion == 8 {
            scoreTitle = "Finish"
            showingScore = false
            endGame = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
