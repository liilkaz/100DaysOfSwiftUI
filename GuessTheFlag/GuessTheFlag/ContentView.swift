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
    
    @State private var tappedFlag: Int? = nil
    
    @State private var animationAmount = 0.0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
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
                            withAnimation(.interpolatingSpring(stiffness: 5, damping: 5)) {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(countrie: countries[number])
                        }
                        .rotation3DEffect(.degrees(number == tappedFlag ? animationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number == tappedFlag ? 1.0 : opacityAnimation(number))
                        .scaleEffect(opacityAnimation(number) == 1 ? 1 : 0.5)
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
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
    
    func noTapAnimationButton(_ number: Int) {
        
    }
    
    func opacityAnimation(_ number: Int) -> Double {
        if number == correctAnswer || tappedFlag == nil {
            return 1.0
        } else {
            return 0.25
        }
    }
    
    func flagTapped(_ number: Int) {
        tappedFlag = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            animationAmount += 360
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        showingScore = true
        numberOfQuestion += 1
    }
    
    func askQuestion() {
        tappedFlag = nil
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
