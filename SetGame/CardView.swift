//
//  CardView.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-19.
//

import SwiftUI

//MARK: - View

struct CardView: View {
    
    //Passed in properties
    let card: Card
    
    //Main view body
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(backgroundColor)
                RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke()
                if card.shape == .diamond {
                    DiamondShape(color: colorToUse, number: numberToUse, shade: shadeToUse)
                }
                else if card.shape == .squiggle {
                    SquiggleShape(color: colorToUse, number: numberToUse, shade: shadeToUse)
                } else {
                    OvalShape(color: colorToUse, number: numberToUse, shade: shadeToUse)
                }
            }
        }
        .aspectRatio(CardConstants.aspectRatio, contentMode: .fit)
    }
    
    //MARK: - Calculated Properties
    
    //FIXED: Take out the return statements since responses are just 1 line
    //figure out what color the card should be
    private var colorToUse: Color {
        if card.color == SetGameModel.cardColors.pink {
            Color(UIColor.pink)
        }
        else if card.color == SetGameModel.cardColors.purple {
            Color(UIColor.purple)
        }
        else {
            Color(UIColor.yellow)
        }
    }
    
    private var backgroundColor: Color {
        if card.cardState == .matched {
            Color(UIColor.matched)
        } else if card.cardState == .mismatched {
            Color(UIColor.mismatched)
        } else if card.cardState == .selected {
            Color(UIColor.selected)
        } else {
            .white
        }
    }
    
    //figure out what number case number is
    var numberToUse: Int {
        if card.number == SetGameModel.cardNumbers.oneShape {
            1
        }
        else if card.number == SetGameModel.cardNumbers.twoShapes {
            2
        }
        else {
            3
        }
    }
    
    //figure out what shade to use
    var shadeToUse: Double {
        if card.shade == SetGameModel.cardShades.opaque {
            1.0
        }
        else if card.shade == SetGameModel.cardShades.translucent {
            0.25
        }
        else {
            0.0
        }
    }
    
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.09
    }
    
    struct CardConstants {
        static let aspectRatio: Double = 8/6
    }
}

#Preview {
    CardView(card: Card(color: .yellow, shape: .diamond, number: .threeShapes, shade: .opaque, cardState: .notSelected))
        .padding(50)
}
