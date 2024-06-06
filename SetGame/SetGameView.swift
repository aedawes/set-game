//
//  SetGameView.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-19.
//

import SwiftUI

//MARK: - View

struct SetGameView: View {
    
    let setGame: SetGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: ViewConstants.spacingAndPaddingSize) {
                VStack(spacing: 0) {
                    //Navigation Bar
                    ZStack {
                        //Background bar
                        Rectangle()
                            .frame(width: geometry.size.width, height: ViewConstants.navbarHeight)
                            .foregroundColor(Color(UIColor.purple))
                        //Buttons and Title
                        HStack {
                            Button("New Game") { //New game button
                                setGame.newGame() //Create a new game, re-deal cards
                            }
                            .font(.system(size: ViewConstants.buttonFontSize))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(width: buttonWidth(for: geometry.size), height: buttonHeight(for: geometry.size))
                            .padding()
                            .background(.white)
                            .cornerRadius(ViewConstants.cornerRadius)
                            .lineLimit(nil)
                            Spacer(minLength: ViewConstants.minSpacerLength)
                            Text("SET")
                                .fontWeight(.bold)
                                .font(.system(size: ViewConstants.titleFontSize))
                                .foregroundColor(.white)
                            Spacer(minLength: ViewConstants.minSpacerLength)
                            Button("Deal 3") { //Deal 3 more cards button
                                setGame.addThreeCards() //Add three more cards based on current game conditions
                            }
                            .font(.system(size: ViewConstants.buttonFontSize))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(width: buttonWidth(for: geometry.size), height: buttonHeight(for: geometry.size))
                            .padding()
                            .background(setGame.entireDeckDealt ? .gray : Color(UIColor.white))
                            .cornerRadius(ViewConstants.cornerRadius)
                            .disabled(setGame.entireDeckDealt)
                        }
                        .padding(.horizontal, ViewConstants.spacingAndPaddingSize)
                    }
                    //Score bar
                    ZStack {
                        Rectangle()
                            .frame(width: geometry.size.width, height: ViewConstants.navbarHeight / 3.5)
                            .foregroundColor(Color(UIColor.pink))
                        HStack {
                            Text("Sets: \(setGame.matches)")
                                .fontWeight(.bold)
                                .font(.system(size: ViewConstants.buttonFontSize))
                                .foregroundColor(.white)
                            Spacer()
                            Text("Score: \(setGame.score)")
                                .fontWeight(.bold)
                                .font(.system(size: ViewConstants.buttonFontSize))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, ViewConstants.spacingAndPaddingSize)
                    }
                }
                //Dealt cards from the deck
                LazyVGrid(columns: columns(for: geometry.size)) {
                    //loop through cards that are dealt
                    ForEach(setGame.dealtCards) { card in
                        CardView(card: card)
                            .transition(AnyTransition.offset(randomOffscreenLocation)) //Allows animation to take place
                            .onTapGesture { setGame.selectCard(card) } //selects card when tapped
                    }
                }
                .padding(.horizontal, gridPadding(for: geometry.size))
            }
        }
        .onAppear { //When the view appears, deal cards then
            setGame.dealCards()
        }
        .ignoresSafeArea(edges: .horizontal)
    }
    
    //MARK: - View Constants
    
    private func navbarHeight(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.03
    }
    
    private func gridPadding(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.07
    }
    
    private func buttonWidth(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.2
    }

    private func buttonHeight(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.03
    }


    private struct ViewConstants {
        static let navbarHeight: Double = 90
        static let buttonFontSize: Double = 15
        static let titleFontSize: Double = 35
        static let cornerRadius: Double = 10
        static let minSpacerLength: CGFloat = 5
        static let spacingAndPaddingSize: Double = 20
    }
    
    //MARK: - Computed
    
    private var randomOffscreenLocation : CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let factor: Double = Int.random(in: 0...1) > 0 ? 1 : -1
        
        return CGSize(width: factor * radius, height: factor * radius)
    }
    
    //MARK: - Drawing constants
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: columnCount(for: size))
    }
    
    private func columnCount(for size: CGSize) -> Int {
        var columns = 2
        let verticalPadding = 115
        let horizontalPadding = 40
        let cardSpacing = 15
        let cardCount = setGame.dealtCards.count
        var spacingWidth: Double
        var spacingHeight: Double
        var cardWidth: Double
        var deckHeight: Double
        var rows: Int
        
        repeat {
            columns += 1
            spacingWidth = Double((columns - 1) * cardSpacing + horizontalPadding)
            cardWidth = (size.width - spacingWidth) / Double(columns)
            rows = (cardCount + columns - 1) / columns
            spacingHeight = Double((rows - 1) * cardSpacing + verticalPadding)
            deckHeight = 6*cardWidth / 8 * Double(rows) + spacingHeight
        } while deckHeight > size.height
        return columns
    }
}

//MARK: - Preview

#Preview {
    SetGameView(setGame: SetGameViewModel())
}
