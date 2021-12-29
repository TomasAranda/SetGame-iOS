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
            AspectVGrid(items: game.cards, aspectRatio: 4/7) { card in
                cardView(for: card)
            }.padding(5)
            Spacer()
            HStack {
                if game.numberOfDealedCards < 81 {
                    Button { game.dealCards() } label: {
                        Text("Deal 3 More Cards")
                    }
                    Spacer()                    
                }
                Button { game.newGame() } label: {
                    Text("New Game")
                }
            }.padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private func cardView(for card: SetGame.Card) -> some View {
        if card.isMatched && game.numberOfDealedCards == 81 {
            Rectangle().opacity(0)
        } else {
            SetCardView(card: card)
                .padding(3)
                .onTapGesture { game.choose(card) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = SetGameViewModel()
        
        return SetGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}
