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
                Text("Button")
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
            let shape = RoundedRectangle(cornerRadius: 10.0).frame(width: 70, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            if card.isSelected {
                shape.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            } else {
                shape.foregroundColor(.black)
            }
            if card.isMatched {
                shape.foregroundColor(Color(red: 0.0, green: 1.0, blue: 0.0, opacity: 0.3))
            }
            
            VStack {
                ForEach(0..<card.attributes.number.rawValue) { _ in
                    if card.attributes.shape == .one {
                        Rectangle()
                            .frame(width: 50, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(color)
                    } else if card.attributes.shape == .two {
                        Capsule()
                            .frame(width: 50, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(color)
                    } else if card.attributes.shape == .three {
                        Circle()
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(color)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
