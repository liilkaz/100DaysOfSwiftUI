//
//  StartModels.swift
//  MultiplicationTables
//
//  Created by Лилия Феодотова on 03.08.2023.
//

import Foundation

struct StartModels{
    var numberOfQuestions = 5
    var arrayNumOfQuestions = [5, 10, 15, 20]
    
    var chooseTable = 2
    
    var isRight = false
    var showAlert = false
    
    var rightAnswer = 0
    var score = 0
    var currentQuestion = 0
    
    var question = "2 x 2"
    var variableOfAnswer: [Int] = [0, 0, 0, 0]
    
    mutating func makeQuestion(){
        let randomNum = Int.random(in: 2...12)
        question = "\(chooseTable + 2) x \(randomNum)"
        
        rightAnswer = (chooseTable + 2) * randomNum
        variableOfAnswer = getVariableOfAnswers(rightAnswer: rightAnswer)
        
        
        
    }
    
    func getVariableOfAnswers(rightAnswer: Int) -> [Int] {
        var answers = [Int]()
        answers.append(rightAnswer)
        
        let min = rightAnswer < 10 ? 1 : rightAnswer - 10
        let max = rightAnswer + 10
        
        for _ in 0..<3 {
            var num: Int
            repeat {
                num = Int.random(in: min...max)
            } while answers.contains(num)
            answers.append(num)
        }
        
        return answers.shuffled()
    }
    
    mutating func checkAnswer(userAnswer: Int){
        if variableOfAnswer[userAnswer] == rightAnswer{
            score += 1
            isRight = true
        } else{
            isRight = false
        }
        currentQuestion += 1
        
        if currentQuestion == numberOfQuestions{
            showAlert = true
        } else {
            makeQuestion()
        }
    }
    
}
