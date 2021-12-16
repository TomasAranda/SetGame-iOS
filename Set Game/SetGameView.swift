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
                        SetCardView(card: card).onTapGesture {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
