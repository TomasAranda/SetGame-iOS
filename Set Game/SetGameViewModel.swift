//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Tomás Aranda on 02/12/2021.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    
    @Published private var model = SetGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: Intents
    func choose(_ card: Card) {
        model.choose(card)
    }
}
