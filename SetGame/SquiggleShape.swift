//
//  Squiggle.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-19.
//

import SwiftUI

//MARK: - View
struct SquiggleShape: View {
    
    //properties of the shape
    let color: Color
    let number: Int
    let shade: Double
    
    //main body of code
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: CardConstants.minSpacerLength)
                HStack(spacing: strokeAndSpacerSize(for: geometry.size)) {
                    Spacer(minLength: CardConstants.minSpacerLength)
                    ForEach(0..<number, id: \.self) { _ in
                        ZStack {
                            Squiggle()
                                .foregroundColor(.white)
                            Squiggle().opacity(shade)
                            Squiggle().stroke(lineWidth: strokeAndSpacerSize(for: geometry.size))
                        }
                        .aspectRatio(CardConstants.aspectRatio, contentMode: .fit)
                        .rotationEffect(Angle.degrees(CardConstants.rotation))
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

private func strokeAndSpacerSize(for size: CGSize) -> Double {
    min(size.width, size.height) * 0.03
}

private func verticalPaddingHeight(for size: CGSize) -> Double {
    size.height * 0.12
}

private struct CardConstants {
    static let aspectRatio: Double = 1/2
    static let rotation: Double = 180
    static let minSpacerLength: CGFloat = 0
}


//MARK: - Shape

//Segments used to draw the squiggle shape
let segments = [
    (CGPoint(x: 630, y: 540), CGPoint(x: 1124, y: 369), CGPoint(x: 897, y: 608)),
    (CGPoint(x: 270, y: 530), CGPoint(x: 523, y: 513), CGPoint(x: 422, y: 420)),
    (CGPoint(x: 50, y: 400), CGPoint(x: 96, y: 656), CGPoint(x: 54, y: 583)),
    (CGPoint(x: 360, y: 120), CGPoint(x: 46, y: 220), CGPoint(x: 191, y: 97)),
    (CGPoint(x: 890, y: 140), CGPoint(x: 592, y: 152), CGPoint(x: 619, y: 315)),
    (CGPoint(x: 1040, y: 150), CGPoint(x: 953, y: 100), CGPoint(x: 1009, y: 69))
]

//Create the squiggle shape
struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        guard let lastSegment = segments.last else {
            return path
        }
        
        path.move(to: lastSegment.0)
        segments.forEach { path.addCurve(to: $0, control1: $1, control2: $2) }
        
        path = path.offsetBy(
            dx: rect.minX - path.boundingRect.minX,
            dy: rect.minY - path.boundingRect.minY
        )
        
        let scale = rect.height / path.boundingRect.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
            .rotated(by: Double.pi / 2)
        
        path = path.applying(transform)
        
        return path.offsetBy(dx: rect.width, dy: 0)
    }
}

//MARK: - Preview
#Preview {
    SquiggleShape(color: .pink, number: 3, shade: 0.25)
}
