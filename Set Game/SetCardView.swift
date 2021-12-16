//
//  SetCardView.swift
//  Set Game
//
//  Created by Roberto Aranda on 16/12/2021.
//

import SwiftUI

struct SetCardView: View {
    let card: SetGame.Card
    var color: Color {
        switch card.attributes.color {
        case .one: return Color.purple
        case .two: return Color.red
        case .three: return Color.green
        }
    }
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10.0).frame(width: 70, height: 100, alignment: .center)
            if card.isSelected {
                shape.foregroundColor(.blue).opacity(0.7)
            } else {
                shape.opacity(0.2)
            }
            if card.isMatched {
                shape.foregroundColor(Color(red: 0.0, green: 1.0, blue: 0.0, opacity: 0.3))
            }
            
            VStack {
                ForEach(0..<card.attributes.number.rawValue) { _ in
                    cardShape()
                }
            }
        }
    }
    
    @ViewBuilder func cardShape() -> some View {
        switch card.attributes.shape {
            case .one: fillShading(shape: Capsule()) // Oval
        // TODO: Make Diamond and Squiggle shapes
            case .two: fillShading(shape: Circle()) // Squiggle
            case .three: fillShading(shape: Rectangle()) // Diamond
        }
    }
    
    @ViewBuilder func fillShading<setShape>(shape: setShape) -> some View where setShape: Shape {
        switch card.attributes.shading {
            case .one: shape.solid(color: color)
            case .two: shape.striped(color: color)
            case .three: shape.open(color: color)
        }
    }
}

extension Shape {
    func solid(color: Color) -> some View {
        self.fill().foregroundColor(color).frame(width: 50, height: 20, alignment: .center)
    }
    
    func open(color: Color) -> some View {
        ZStack{
            self.fill().foregroundColor(.white).frame(width: 50, height: 20, alignment: .center)
            self.stroke(color, lineWidth: 3).frame(width: 50, height: 20, alignment: .center)
        }
    }

    func striped(color: Color) -> some View {
        ZStack {
            self.fill().foregroundColor(color).opacity(0.2).frame(width: 50, height: 20, alignment: .center)
            self.stroke(color, lineWidth: 3).frame(width: 50, height: 20, alignment: .center)
        }
    }
}

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = SetGame().cards[0]
        SetCardView(card: card)
    }
}
