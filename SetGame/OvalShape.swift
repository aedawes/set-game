//
//  Oval.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-20.
//

import SwiftUI

//MARK: - View

struct OvalShape: View {
    
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
                            Capsule()
                                .foregroundColor(.white)
                            Capsule().opacity(shade)
                            Capsule().stroke(lineWidth: strokeSize(for: geometry.size))
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


//MARK: - Preview

#Preview {
    OvalShape(color: .pink, number: 3, shade: 0.25)
        .padding(150)
}
