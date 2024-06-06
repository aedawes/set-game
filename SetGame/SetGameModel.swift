//
//  SetGameModel.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-19.
//

import Foundation

struct SetGameModel {
    
    //MARK: - Properties
    
    var cardDeck: CardDeck
    var dealtCards: [Card]
    var initialNumOfCardsDealt: Int
    var entireDeckDealt: Bool
    var score: Int
    var matches: Int
    
    enum cardColors: CaseIterable {
        case purple
        case yellow
        case pink
    }
    
    enum cardShapes: CaseIterable {
        case diamond
        case oval
        case squiggle
    }
    
    enum cardNumbers: Int, CaseIterable {
        case oneShape = 1
        case twoShapes = 2
        case threeShapes = 3
    }
    
    enum cardShades: CaseIterable {
        case solid
        case translucent
        case opaque
    }
    
    //MARK: - Initialization
    
    init() {
        cardDeck = CardDeck()
        initialNumOfCardsDealt = 12
        dealtCards = []
        entireDeckDealt = false
        score = 0
        matches = 0
    }
    
    mutating func initializeDealtCards() {
        for _ in 0..<initialNumOfCardsDealt {
            addACard()
        }
    }
    
    
    //MARK: - Methods
    
    mutating func addACard() { //Adds a card to the dealt cards and removes it from the deck
        if let cardToAppend = cardDeck.cards.first {
            dealtCards.append(cardToAppend)
            cardDeck.cards.removeFirst()
        }
    }
    
    mutating func select(card: Card) { //Change state of selected card and evaluate if three are chosen
        if let foundIndex = dealtCards.firstIndex(matching: card) {
            
            //If there are any "mismatched cards", change to "notSelected"
            for card in dealtCards {
                if card.cardState == .mismatched,
                   let matchIndex = dealtCards.firstIndex(of: card) {
                    dealtCards[matchIndex].cardState = .notSelected
                }
            }
            
            //Toggle between selected and notselected card states
            if dealtCards[foundIndex].cardState == .selected {
                dealtCards[foundIndex].cardState = .notSelected
            } else {
                dealtCards[foundIndex].cardState = .selected
            }
            
            //Figure out what cards are selected
            let selectedCards = dealtCards.filter {
                $0.cardState == .selected
            }
            
            //If there are three selected cards, see if they are a set
            //If they are a set, set state to matched, if not, mismatched
            if selectedCards.count == 3 {
                if chosenCardsAreASet(selectedCards) {
                    addToScore()
                    matches += 1
                    selectedCards.forEach() { card in
                        if let foundIndex = dealtCards.firstIndex(matching: card) {
                            dealtCards[foundIndex].cardState = .matched
                        }
                    }
                } else {
                    selectedCards.forEach() { card in
                        if let foundIndex = dealtCards.firstIndex(matching: card) {
                            dealtCards[foundIndex].cardState = .mismatched
                        }
                    }
                }
            }
        }
    }
    
    mutating func addToScore() {
        if dealtCards.count < 13 {
            score += 6
        } else if dealtCards.count < 22 {
            score += 5
        } else if dealtCards.count < 36 {
            score += 4
        } else if dealtCards.count < 54 {
            score += 3
        } else if dealtCards.count < 78 {
            score += 2
        } else {
            score += 1
        }
    }
    
    //Evaluate to see if the provided attribute (color/shapes/number/shade) is all unique or all the same
    func isNotASet<T: Hashable>(_ attributes: [T]) -> Bool {
        
        //returns true if the provided array is not either unique or completely the same
        Set(attributes).count == 2
    }
    
    func chosenCardsAreASet(_ cards: [Card]) -> Bool {
        
        //create arrays for the attributes of each card
        var colors: Array<cardColors> = []
        var shapes: Array<cardShapes> = []
        var numbers: Array<cardNumbers> = []
        var shades: Array<cardShades> = []
        
        //Populate the arrays
        cards.forEach() { card in
            colors.append(card.color)
            shapes.append(card.shape)
            numbers.append(card.number)
            shades.append(card.shade)
        }
        
        //Check to see if any of the cards have two of the same attribute
        if isNotASet(colors) || isNotASet(shapes) || isNotASet(numbers) || isNotASet(shades) {
            return false
        }
        
        return true
    }
}
