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
            Text(String(game.cards[1].attributes.color.rawValue))
            
            Spacer()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70, maximum: 70))], spacing: 2) {
                    ForEach(game.cards) { card in
                        CardView(card: card).onTapGesture {
                            game.choose(card)
                        }
                    }
                }
            }
        }
    }
}

struct CardView: View {
    let card: SetGame.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10.0)
            shape.fill().foregroundColor(.gray)
            shape.strokeBorder(Color.red, lineWidth: 1.0)
            
            if card.isSelected {
                shape.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            if card.isMatched {
                shape.foregroundColor(.green)
            }
            
            VStack {
                ForEach(card.attributes.toArrayOfRawValues(), id: \.self) { attr in
                    Text(String(attr))
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
