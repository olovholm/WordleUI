//
//  WordleApp.swift
//  Wordle
//
//  Created by Ola Loevholm on 14/04/2025.
//

import SwiftUI

@main
struct WordleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(word: .constant("HOUSE"))
        }
    }
}
