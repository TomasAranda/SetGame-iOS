//
//  SetGame.swift
//  Set Game
//
//  Created by Tomás Aranda on 01/12/2021.
//

import Foundation

struct SetGame {
    static let initialDealedCards = 12
    
    private(set) var deck: Array<Card>
    private(set) var dealedCards = Array<Card>()
    
    private(set) var idsOfSelectedCards = Array<Int>()
    private(set) var matchedCards = Array<Card>()
    private var thereAreDealedCardsMatched: Bool { dealedCards.contains { $0.isMatched } }
    
    init () {
        self.deck = SetGame.generateCardDeck()
    }
    
    // -- select card --
    mutating func choose(_ card: Card) {
        if let choosenIndex = dealedCards.firstIndex(where: { $0.id == card.id }),
           !dealedCards[choosenIndex].isMatched {
            if idsOfSelectedCards.count < 3 {
                if dealedCards[choosenIndex].isSelected {
                    // -- deselection of card already selected --
                    idsOfSelectedCards.remove(at: idsOfSelectedCards.firstIndex(of: dealedCards[choosenIndex].id)!)
                    dealedCards[choosenIndex].isSelected = false
                    return
                }
                // -- selection --
                dealedCards[choosenIndex].isSelected = true
                idsOfSelectedCards.append(dealedCards[choosenIndex].id)
                if idsOfSelectedCards.count == 3 {
                    // -- matching check --
                    let arrayOfSelectedCards = dealedCards.filter { idsOfSelectedCards.contains($0.id) }
                    if isSet(of: arrayOfSelectedCards) {
                        dealedCards.indices.forEach {
                            if idsOfSelectedCards.contains(dealedCards[$0].id) {
                                dealedCards[$0].isMatched = true
                                dealedCards[$0].isSelected = false
                            }
                        }
                    }
                }
            } else {
                // -- idsOfSelectedCards.count will be 3 --
                dealedCards.indices.forEach { dealedCards[$0].isSelected = false }
                idsOfSelectedCards.removeAll()
                idsOfSelectedCards.append(dealedCards[choosenIndex].id)
                dealedCards[choosenIndex].isSelected = true
                if deck.count == 0 && thereAreDealedCardsMatched {
                    dealedCards.indices.reversed().forEach {
                        if dealedCards[$0].isMatched {
                            matchedCards.append(dealedCards[$0])
                            dealedCards.remove(at: $0)
                        }
                    }
                }
            }
        }
    }
    
    mutating func dealCards() {
        guard dealedCards.count < 81 else { return }
        let numberOfCardsToDeal = dealedCards.count > 0 ? 3 : SetGame.initialDealedCards
        
        if thereAreDealedCardsMatched {
            var replacedCards = 0
            dealedCards.indices.forEach {
                if dealedCards[$0].isMatched && replacedCards < 3 {
                    matchedCards.append(dealedCards[$0])
                    dealedCards[$0] = deck[0]
                    deck.remove(at: 0)
                    replacedCards += 1
                }
            }
        } else {
            dealedCards.append(contentsOf: deck[0..<numberOfCardsToDeal])
            deck.removeSubrange(0..<numberOfCardsToDeal)
        }
    }
        
    private func isSet(of cards: Array<Card>) -> Bool {
        guard cards.count == 3 else { return false }
        
        let sumOfRawValues = cards.reduce(into: [0, 0, 0, 0], { sum, card in
            let rawValues = card.attributes.toArrayOfRawValues()
            for (index, value) in rawValues.enumerated() {
                sum[index] += value
            }
        })
        
        return sumOfRawValues.allSatisfy { value in
            value % 3 == 0
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        let attributes: CardAttributes
        
        var isSelected = false
        var isMatched = false
    
        struct CardAttributes {
            let number: CardAttributeVariant
            let shape: CardAttributeVariant
            let color: CardAttributeVariant
            let shading: CardAttributeVariant
        }
    }
}

enum CardAttributeVariant: Int, CaseIterable {
    case one = 1, two, three
}
