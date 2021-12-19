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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70, maximum: 70))], spacing: 5) {
                ForEach(game.cards) { card in
                    if card.isMatched && game.numberOfDealedCards == 81 {
                        RoundedRectangle(cornerRadius: 10.0).frame(width: 70, height: 100, alignment: .center).foregroundColor(Color(UIColor.systemBackground))
                    } else {
                        SetCardView(card: card).onTapGesture {
                            game.choose(card)
                        }
                    }
                }
            }
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = SetGameViewModel()
        for _ in 0..<7 {
            game.cards.forEach {
                game.choose($0)
            }
        }
        
        return SetGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
