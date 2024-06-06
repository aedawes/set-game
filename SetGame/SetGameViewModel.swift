//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-19.
//

import SwiftUI

@Observable class SetGameViewModel {
    
    //MARK: - Properties
    
    private var game = SetGameModel() //Call to the model
    
    
    //MARK: - Model access
    
    var dealtCards: [Card] { //Cards that have been dealt
        game.dealtCards
    }
    
    var entireDeckDealt: Bool { //Tells whether the entire deck has been dealt
        game.entireDeckDealt
    }
    
    var score: Int {
        game.score
    }
    
    var matches: Int {
        game.matches
    }
    
    //MARK: - User intents
    
    func addThreeCards() { //Deals three more cards to dealt deck
        
        //If cardDeck is empty, the entire deck has been dealt
        if game.cardDeck.cards.count == 0 {
            game.entireDeckDealt = true
        }
        
        //If there are matched cards, replace these cards if the deck is not empty
        var containsMatch = false
        var animationDelay = 0
        for card in game.dealtCards {
            let animationLength = Constants.animationDuration * Double(animationDelay)
            withAnimation(.easeIn(duration: Constants.animationDuration).delay(animationLength)) {
                if card.cardState == .matched,
                   let matchIndex = game.dealtCards.firstIndex(of: card) {
                    containsMatch = true
                    if let cardToAppend = game.cardDeck.cards.first {
                        game.dealtCards[matchIndex] = cardToAppend
                        animationDelay += 1
                        game.cardDeck.cards.removeFirst()
                    }
                }
            }
        }
        
        //If there are no matched cards, add three more if the deck is not empty
        if !containsMatch {
            
            for index in 0..<3 {
                let animationLength = Constants.animationDuration * Double(index)
                withAnimation(.easeIn(duration: Constants.animationDuration).delay(animationLength)) {
                    game.addACard()
                }
            }
        }
    }
    
    //Deals the initial cards at the start of a game
    func dealCards() {
        
        for index in 0..<game.initialNumOfCardsDealt {
            let animationLength = Constants.animationDuration * Double(index)
            withAnimation(.easeIn(duration: Constants.animationDuration).delay(animationLength)) {
                game.addACard()
            }
        }
    }
    
    //Starts a new game
    func newGame() {
        
        game = SetGameModel()
        dealCards()
    }
    
    //Lets a user select a card and evaluates a set if three are selected
    func selectCard( _ card: Card) {
        
        //If cardDeck is empty, the entire deck has been dealt
        if game.cardDeck.cards.count == 0 {
            game.entireDeckDealt = true
        }
        
        //If there are any "matched" cards, replace them
        var animationDelay = 0
        for card in game.dealtCards {
            if card.cardState == .matched,
               let matchIndex = game.dealtCards.firstIndex(of: card) {
                let animationLength = Constants.animationDuration * Double(animationDelay)
                withAnimation(.easeIn(duration: Constants.animationDuration).delay(animationLength)) {
                    if let cardToAppend = game.cardDeck.cards.first {
                        game.dealtCards[matchIndex] = cardToAppend
                        animationDelay += 1
                        game.cardDeck.cards.removeFirst()
                    } else {
                        game.dealtCards.remove(at: matchIndex)
                    }
                }
            }
        }
        
        //run the select function in model
        game.select(card: card)
    }
    
    //MARK: - Constants
    
    private struct Constants {
        static let animationDuration = 0.3
    }
    
}

