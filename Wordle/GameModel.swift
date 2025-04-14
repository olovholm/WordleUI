//
//  GameModel.swift
//  Wordle
//
//  Created by Ola Loevholm on 14/04/2025.
//

import Foundation


class Game: Identifiable, ObservableObject {
    let id = UUID()
    @Published var word: String = ""
    
    func isLetterInRightplace(character: Character, index: Int) -> Bool {
        Array(word)[index] == character
    }
    
    func isLetterInWord(character: Character) -> Bool{
        word.contains(character)
    }
    
    init(word: String) throws {
        guard !word.isEmpty else {
            throw GameError.emptyWord
        }
        guard word.count == 5 else {
            throw GameError.wordNotFiveCharactersLong
        }
        
        self.word = word
    }
}


enum GameError : Error {
    case emptyWord
    case wordNotFiveCharactersLong
    case couldNotCreateWord
}

func getRandomWord () throws -> String {
    let listOfWords = [
        "Apple",
        "Bread",
        "Chair",
        "Dance",
        "Eagle",
        "Frame",
        "Grass",
        "House",
        "Inbox",
        "Jelly",
        "Knife",
        "Light",
        "Magic",
        "Nurse",
        "Ocean",
        "Paint",
        "Queen",
        "River",
        "Sharp",
        "Train",
        "Unity",
        "Vivid",
        "Water",
        "Xylen",
        "Yacht",
        "Zebra",
        "Alarm",
        "Blend",
        "Crack",
        "Drift",
        "Earth",
        "Flute",
        "Ghost",
        "Heart",
        "Ideal",
        "Jolly",
        "Knock",
        "Lemon",
        "Metal",
        "North",
        "Orbit",
        "Plant",
        "Quiet",
        "Roast",
        "Smile",
        "Tooth",
        "Urban",
        "Value",
        "Whale",
        "Youth",
        "Angry",
        "Brave",
        "Crisp",
        "Devil",
        "Exist",
        "Flare",
        "Gloom",
        "Humor",
        "Input",
        "Joint",
        "Kneel",
        "Loyal",
        "Mirth",
        "Noble",
        "Pearl",
        "Quest",
        "React",
        "Skill",
        "Tasty",
        "Unzip",
        "Visit",
        "Wound",
        "Xerox",
        "Yield",
        "Zebra",
        "Actor",
        "Beach",
        "Cloud",
        "Dream",
        "Enjoy",
        "Flora",
        "Glory",
        "Honey",
        "Ivory",
        "Jewel",
        "Karma",
        "Laugh",
        "Mango",
        "Nerve",
        "Oasis",
        "Pride",
        "Quiet",
        "Royal",
        "Sleep",
        "Tiger",
        "Usual",
        "Video",
        "World",
        "Zoney"
    ]
    
    guard let word = listOfWords.randomElement() else {
        throw GameError.couldNotCreateWord
    }
    
    return word.uppercased()
}
