//
//  Card.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-26.
//

import Foundation

struct Card: Identifiable, Equatable, Hashable{
    
    //MARK: - Properties
    
    fileprivate(set) var id = UUID()
    fileprivate(set) var color: SetGameModel.cardColors
    fileprivate(set) var shape: SetGameModel.cardShapes
    fileprivate(set) var number: SetGameModel.cardNumbers
    fileprivate(set) var shade: SetGameModel.cardShades
    
    var cardState: state
    
    enum state: CaseIterable {
        case selected
        case notSelected
        case matched
        case mismatched
    }
}
