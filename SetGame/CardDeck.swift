//
//  CardDeck.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-26.
//

import Foundation

struct CardDeck {
    
    //MARK: - Properties
    
    var cards: [Card] = []
    
    
    //MARK: - Initialization
    
    //Call the populate function
    init() {
        populateCardDeck()
    }
    
    //MARK: - Methods
    
    // populating the card deck
    mutating func populateCardDeck() {
        for cardColor in SetGameModel.cardColors.allCases {
            for cardShape in SetGameModel.cardShapes.allCases {
                for cardNumber in SetGameModel.cardNumbers.allCases {
                    for cardShade in SetGameModel.cardShades.allCases {
                        let cardToAppend = Card(color: cardColor, shape: cardShape, number: cardNumber, shade: cardShade, cardState: Card.state.notSelected)
                        cards.append(cardToAppend)
                    }
                }
            }
        }
        cards.shuffle()
    }
}
