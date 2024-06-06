//
//  SetGameApp.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-19.
//

import SwiftUI

//FIXED:
// - If the method returns only one line, I took out the return
// - Added a white background to shapes so that when they are shaded, they are not passthrough

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(setGame: SetGameViewModel())
        }
    }
}
