//
//  SetCardView.swift
//  Set Game
//
//  Created by Tomás Aranda on 16/12/2021.
//

import SwiftUI

struct SetCardView: View {
    let card: SetGame.Card
    private var color: Color {
        switch card.attributes.color {
            case .one: return Color.purple
            case .two: return Color.red
            case .three: return Color.green
        }
    }
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 8.0)
            if card.isSelected {
                shape.foregroundColor(.blue).opacity(0.5)
            } else {
                shape.opacity(0.2)
            }
            if card.isMatched {
                shape.foregroundColor(.green).opacity(0.3)
            }
            
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    ForEach(0..<card.attributes.number.rawValue, id: \.self) { _ in
                        cardShape()
                            .frame(width: geometry.size.width * 0.8,
                                   height: geometry.size.height * 0.2,
                                   alignment: .center)
                    }
                }.padding(40.0)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
    
    @ViewBuilder
    private func cardShape() -> some View {
        switch card.attributes.shape {
            case .one: fillShading(shape: Capsule())
            case .two: fillShading(shape: Squiggle())
            case .three: fillShading(shape: Diamond())
        }
    }
    
    @ViewBuilder
    private func fillShading<setShape>(shape: setShape) -> some View where setShape: Shape {
        switch card.attributes.shading {
            case .one: shape.solid(color: color)
            case .two: shape.striped(color: color)
            case .three: shape.open(color: color)
        }
    }
}

extension Shape {
    func solid(color: Color) -> some View {
        self.fill().foregroundColor(color)
    }
    
    func open(color: Color) -> some View {
        ZStack{
            self.stroke(color, lineWidth: 3)
        }
    }

    func striped(color: Color) -> some View {
        ZStack {
            HStack(spacing: 0) {
                ForEach(0..<5, id: \.self) { number in
                    Spacer(minLength: 0)
                    color.frame(width: 2)
                }
            }.mask(self)
            self.stroke(color, lineWidth: 3)
        }
    }
}

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = SetGame().dealedCards[0]
        SetCardView(card: card)
    }
}
