//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Лилия Феодотова on 18.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var atributes = ["👊","✌️","🤚"]
    @State private var winCombination = ["🤚","👊","✌️"]
    @State private var loseCombination = ["✌️","🤚","👊"]
    
    @State private var score = 0
    @State private var numberOfQuestion = 0
    @State private var gameStatus = ""
    @State private var endGame = false
    
    @State private var numberOfLives = 3
    @State private var lives = ["❤️","❤️","❤️"]
    
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var winOrLose = Bool.random()
    @State private var playerAnswers = ["❔", "❔", "❔", "❔", "❔", "❔", "❔", "❔", "❔", "❔"]
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: .blue, location: 0.1),
                .init(color: .purple, location: 0.7)
            ], startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea() // background
            VStack(spacing: 30) {
                Spacer()
                HStack {
                    Spacer()
                    ForEach(0..<3) { live in
                        Text(lives[live]).font(.system(size: 30))
                    }
                } // lives
                Text("Select an emoji to ").font(.title.weight(.medium)).foregroundColor(.white) + Text(winOrLose ? "WIN" : "LOSE")
                    .foregroundColor(winOrLose ? .green : .red)
                    .font(.largeTitle.weight(.semibold)) // task
                Text(atributes[currentChoice]).font(.system(size: 200)) //atribute
                HStack(spacing: 15){
                    ForEach(0..<3) { number in
                        Button {
                            atributeTapped(atributes[number])
                        } label: {
                            Text(atributes[number]).font(.system(size: 100))
                        }
                    }
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                } //buttons
                Text("Score: \(score)").font(.title.weight(.semibold)).foregroundColor(.white) //score
                Spacer()
                HStack(spacing: 5){
                    ForEach(0..<10) { question in
                        Text(playerAnswers[question]).font(.system(size: 27))
                    }
                    .background(.thinMaterial)
                } //statistics
            }
            .padding()
        }
        .alert(gameStatus, isPresented: $endGame) {
            Button("Restart") {
                updateQuestion()
                resetResult()
            }
        } message: {
            Text("Your final score is \(score)")
        } //alert
    }
    
    func updateQuestion() {
        if numberOfQuestion == 9 {
            gameStatus = "Finish"
            endGame = true
        } else {
            numberOfQuestion += 1
            currentChoice = Int.random(in: 0...2)
            winOrLose = Bool.random()
        }
    }
    
    func resetResult() {
        score = 0
        numberOfQuestion = 0
        numberOfLives = 3
        lives = ["❤️","❤️","❤️"]
        playerAnswers = ["❔", "❔", "❔", "❔", "❔", "❔", "❔", "❔", "❔", "❔"]
    }
    
    func atributeTapped(_ answer: String) {
        if (winCombination[currentChoice] == answer && winOrLose) || (loseCombination[currentChoice] == answer && !winOrLose) {
            scoringPoints("right")
        } else if (loseCombination[currentChoice] == answer && winOrLose) || (winCombination[currentChoice] == answer && !winOrLose) {
            scoringPoints("wrong")
        }
        else {
            scoringPoints("draw")
        }
        updateQuestion()
    }
    
    func scoringPoints(_ answer: String){
        if answer == "right" {
            score += 1
            playerAnswers.insert("✅", at: numberOfQuestion)
        } else if answer == "wrong" {
            if (score > 0){
                (score -= 1)
            } else{
                (score = 0)
            }
            looseLive()
            playerAnswers.insert("❌", at: numberOfQuestion)
        } else {
            playerAnswers.insert("➖", at: numberOfQuestion)
        }
    }
    
    func looseLive() {
        if numberOfLives > 1{
            numberOfLives -= 1
            lives.insert("💔", at: 0)
        } else {
            lives.insert("💔", at: 0)
            gameStatus = "Finish"
            endGame = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
