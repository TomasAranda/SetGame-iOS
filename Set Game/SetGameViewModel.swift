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
    
    var deck: Array<Card> {
        model.deck
    }
    
    var dealedCards: Array<Card> {
        model.dealedCards
    }
    
    var matchedCards: Array<Card> {
        model.matchedCards
    }
    
    var selectedCards: Array<Card> {
        model.dealedCards.filter({ $0.isSelected })
    }
    
    // MARK: Intents
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealCards() {
        model.dealCards()
    }
    
    func newGame() {
        model = SetGame()
    }
}
