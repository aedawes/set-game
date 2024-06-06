//
//  DiamondShape.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-19.
//

import SwiftUI

//MARK: - View

struct DiamondShape: View {
    
    let color: Color
    let number: Int
    let shade: Double
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: CardConstants.minSpacerLength)
                HStack(spacing: spacerSize(for: geometry.size)) {
                    Spacer(minLength: CardConstants.minSpacerLength)
                    ForEach(0..<number, id: \.self) { _ in
                        ZStack {
                            Diamond()
                                .foregroundColor(.white)
                            Diamond().opacity(shade)
                            Diamond().stroke(lineWidth: strokeSize(for: geometry.size))
                        }
                        .aspectRatio(CardConstants.aspectRatio, contentMode: .fit)
                    }
                    .foregroundStyle(color)
                    Spacer(minLength: CardConstants.minSpacerLength)
                }
                .padding(.vertical, verticalPaddingHeight(for: geometry.size))
                Spacer(minLength: CardConstants.minSpacerLength)
            }
        }
    }
}

//MARK: - Constants

private func strokeSize(for size: CGSize) -> Double {
    min(size.width, size.height) * 0.03
}

private func spacerSize(for size: CGSize) -> Double {
    min(size.width, size.height) * 0.08
}

private func verticalPaddingHeight(for size: CGSize) -> Double {
    size.height * 0.12
}

private struct CardConstants {
    static let aspectRatio: Double = 1/2
    static let minSpacerLength: CGFloat = 0
}

//MARK: - Shape

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //find the width and height of the diamond
        let diamondWidth = rect.size.width
        let diamondHeight = rect.size.height
        
        //calculate the points based off of the center and the height/width
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        let topPoint = CGPoint(x: centerPoint.x, y: centerPoint.y + (diamondHeight / 2))
        let bottomPoint = CGPoint(x: centerPoint.x, y: centerPoint.y - (diamondHeight / 2))
        let rightPoint = CGPoint(x: centerPoint.x - (diamondWidth / 2), y: centerPoint.y)
        let leftPoint = CGPoint(x: centerPoint.x + (diamondWidth / 2), y: centerPoint.y)
        
        //draw the shape
        path.move(to: leftPoint)
        path.addLine(to: bottomPoint)
        path.addLine(to: rightPoint)
        path.addLine(to: topPoint)
        path.closeSubpath()
        
        return path
    }
}

//MARK: - Preview

#Preview {
    DiamondShape(color: .pink, number: 3, shade: 0.25)
        .padding(150)
}

