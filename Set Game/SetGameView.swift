//
//  ContentView.swift
//  Set Game
//
//  Created by Tomás Aranda on 01/12/2021.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70, maximum: 70))], spacing: 5) {
                    ForEach(game.cards) { card in
                        CardView(card: card).onTapGesture {
                            game.choose(card)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button { game.newGame() } label: {
                Text("New Game")
            }
        }
    }
}

struct CardView: View {
    let card: SetGame.Card
    var color: Color {
        switch card.attributes.color {
        case .one:
            return Color.purple
        case .two:
            return Color.red
        case .three:
            return Color.green
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
                    switch card.attributes.shape {
                    case .one:
                        RectangleView(shading: card.attributes.shading, color: color)
                    case .two:
                        CapsuleView(shading: card.attributes.shading, color: color)
                    case .three:
                        CircleView(shading: card.attributes.shading, color: color)
                    }
                }
            }
        }
    }
}

struct RectangleView: View {
    let shading: CardAttributeVariant
    let color: Color
    
    var body: some View {
        ZStack {
            let shape = Rectangle()
            
            switch shading {
                case .one:
                    shape.fill().frame(width: 50, height: 20, alignment: .center)
                    shape.strokeBorder(color, lineWidth: 3).frame(width: 50, height: 20, alignment: .center)
                case .two:
                    shape.fill().foregroundColor(color).opacity(0.2).frame(width: 50, height: 20, alignment: .center)
                    shape.strokeBorder(color, lineWidth: 3).frame(width: 50, height: 20, alignment: .center)
                case .three:
                    shape.fill().foregroundColor(color).frame(width: 50, height: 20, alignment: .center)
            }
        }
    }
}

struct CapsuleView: View {
    let shading: CardAttributeVariant
    let color: Color
    
    var body: some View {
        ZStack {
            let shape = Capsule()
            switch shading {
                case .one:
                    shape.fill().frame(width: 50, height: 20, alignment: .center)
                    shape.strokeBorder(color, lineWidth: 3).frame(width: 50, height: 20, alignment: .center)
                case .two:
                    shape.fill().foregroundColor(color).opacity(0.2).frame(width: 50, height: 20, alignment: .center)
                    shape.strokeBorder(color, lineWidth: 3).frame(width: 50, height: 20, alignment: .center)
                case .three:
                    shape.fill().foregroundColor(color).frame(width: 50, height: 20, alignment: .center)
            }
        }
    }
}

struct CircleView: View {
    let shading: CardAttributeVariant
    let color: Color
    
    var body: some View {
        ZStack {
            let shape = Circle()
            switch shading {
                case .one:
                    shape.fill().frame(width: 20, height: 20, alignment: .center)
                    shape.strokeBorder(color, lineWidth: 3).frame(width: 20, height: 20, alignment: .center)
                case .two:
                    shape.fill().foregroundColor(color).opacity(0.2).frame(width: 20, height: 20, alignment: .center)
                    shape.strokeBorder(color, lineWidth: 3).frame(width: 20, height: 20, alignment: .center)
                case .three:
                    shape.fill().foregroundColor(color).frame(width: 20, height: 20, alignment: .center)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}
