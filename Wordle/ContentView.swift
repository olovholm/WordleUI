//
//  ContentView.swift
//  Wordle
//
//  Created by Ola Loevholm on 14/04/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var guesses: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 6)
    @State private var currentRow = 0
    @State private var letterStatuses: [[LetterStatus]] = Array(repeating: Array(repeating: .absent, count: 5), count: 6)
    @Binding var word : String

    
    
    var body: some View {
        VStack {
            ForEach(0..<6, id: \.self) { row in
                HStack {
                    ForEach(0..<5, id: \.self) { col in
                        let isEditable = row == currentRow
                        TextField("", text: Binding(
                            get: { guesses[row][col] },
                            set: { newValue in
                                if isEditable {
                                    if let char = newValue.last?.uppercased(),
                                       char.range(of: "[A-Z]", options: .regularExpression) != nil {
                                        guesses[row][col] = String(char)
                                    } else {
                                        guesses[row][col] = ""
                                    }
                                }
                            }))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                        .border(.gray)
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .disabled(!isEditable)
                        .background(letterStatuses[row][col].toColor())

                        
                    }
                }
            }
        }
        .padding()
        Button("Submit") {
            if isGuessValid(guesses[currentRow]) {
                checkGuess(guess: guesses[currentRow])
                currentRow += 1
                prepareRow(currentRow: currentRow)
            }
        }
        .disabled(!isRowFilled(guesses[currentRow]))
        .padding()
    }
    
    func isRowFilled(_ row: [String]) -> Bool {
        return row.allSatisfy { $0.count == 1 }
    }
    
    func checkGuess(guess: [String]) {
        //Update letter statuses
        let wordLetters = Array(word.uppercased())
        print("Got letter \(guess)")
        
        for (index, letter) in guess.enumerated() {
            let charLetter = Character(letter)
            print("Going to see if \(charLetter) is in \(word)")
            if(wordLetters[index] == charLetter) {
                print("Letter \(letter) is correct")
                letterStatuses[currentRow][index] = .correct
            } else if(word.contains(letter)){
                print("Letter \(letter) in in word")
                letterStatuses[currentRow][index] = .present
            } else {
                print("Letter \(letter) is absent")
                letterStatuses[currentRow][index] = .absent
            }
            
        }
        
        // Check if word is correct
        //String(guess.joined()).uppercased() == word.uppercased()
    }

    func isGuessValid(_ guess: [String]) -> Bool {
        // TODO: Add dictionary lookup later
        return isRowFilled(guess)
    }
    
    func prepareRow(currentRow: Int) {
        var word = Array(repeating: "", count: word.count)
        for (index, letterStatus) in letterStatuses[currentRow-1].enumerated() {
            if(letterStatus == .correct) {
                print("Updates \(guesses[currentRow]) from \(guesses[currentRow-1])")
                guesses[currentRow][index] = guesses[currentRow-1][index]
                letterStatuses[currentRow][index] = letterStatuses[currentRow-1][index]
            }
            
        }
        guesses[currentRow]
        print("Old row is \(guesses[currentRow-1]) and new is \(guesses[currentRow])")
    }
    
    
    enum LetterStatus {
        case correct
        case present
        case absent
        
        func toColor() -> Color {
            switch(self) {
            case .correct:
                    .green
            case .present:
                    .yellow
            case .absent:
                    .white
            }
        }
        
    }

}

#Preview {
    ContentView(word: .constant("HOUSE"))
}
