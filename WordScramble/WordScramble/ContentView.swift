//
//  ContentView.swift
//  WordScramble
//
//  Created by Лилия Феодотова on 24.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                Section {
                    ForEach(usedWords, id: \.self){word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)}
                    }
                }
                Text("Score: \(score)")
            }
            .navigationTitle(rootWord)
            .toolbar{
                Button("New word", action: startGame)
                
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOrigin(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible ", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isShort(word: answer) else {
            wordError(title: "Word is very short", message: "You can't entered this word!")
            return
        }
        
        guard isRoot(word: answer) else {
            wordError(title: "Word is root", message: "You can't entered this word!")
            return
        }
        
        score(word: answer)
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: .newlines)
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOrigin(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isShort(word: String) -> Bool {
        !(word.count < 3)
    }
    
    func isRoot(word: String) -> Bool {
        !(word == rootWord)
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func score(word: String) {
        var count = word.count
        if count <= 3 {
            score += 1
        } else if count > 3 && count < 5 {
            score += 2
        } else if count > 5 && count < 7 {
            score += 3
        } else {
            score += 4
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
