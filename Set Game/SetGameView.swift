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
            Text(String(game.cards.count))
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 20, maximum: 30))], spacing: 0) {
                ForEach(game.cards) { card in
                    Text(String(card.id))
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
