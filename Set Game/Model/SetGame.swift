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
    private(set) var numberOfDealedCards = 0
    private(set) var dealedCards: Array<Card>
    
    private(set) var idsOfSelectedCards = Array<Int>()
    var thereAreMatchedCards: Bool { dealedCards.contains { $0.isMatched } }
    
    init () {
        self.deck = SetGame.generateCardDeck()
        self.dealedCards = Array()
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
                    if SetGame.isSet(of: arrayOfSelectedCards) {
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
                if numberOfDealedCards < deck.count && thereAreMatchedCards {
                    dealCards()
                }
                dealedCards.indices.forEach { dealedCards[$0].isSelected = false }
                idsOfSelectedCards.removeAll()
                idsOfSelectedCards.append(dealedCards[choosenIndex].id)
                dealedCards[choosenIndex].isSelected = true
            }
        }
    }
    
    mutating func dealCards() {
        guard numberOfDealedCards < deck.count else { return }
        let numberOfCardsToDeal = dealedCards.count > 0 ? 3 : SetGame.initialDealedCards
        
        if thereAreMatchedCards {
            dealedCards.indices.forEach {
                if dealedCards[$0].isMatched {
                    dealedCards[$0] = deck[numberOfDealedCards]
                    numberOfDealedCards += 1
                }
            }
        } else {
            dealedCards.append(contentsOf: deck[numberOfDealedCards..<numberOfDealedCards+numberOfCardsToDeal])
            numberOfDealedCards += numberOfCardsToDeal
        }
    }
        
    private static func isSet(of cards: Array<Card>) -> Bool {
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

extension SetGame {
    private static func generateCardDeck() -> Array<Card> {
        var deck = Array<Card>()
        var incrementalId = 0
        
        for number in CardAttributeVariant.allCases {
            for shape in CardAttributeVariant.allCases {
                for color in CardAttributeVariant.allCases {
                    for shading in CardAttributeVariant.allCases {
                        incrementalId += 1
                        deck.append(Card(
                            id: incrementalId,
                            attributes: Card.CardAttributes(
                                number: number,
                                shape: shape,
                                color: color,
                                shading: shading
                            )
                        ))
                    }
                }
            }
        }
        
        return deck.shuffled()
    }
}

enum CardAttributeVariant: Int, CaseIterable {
    case one = 1, two, three
}

extension SetGame.Card.CardAttributes {
    func toArrayOfRawValues() -> [Int] {
        return [
            self.number.rawValue,
            self.shape.rawValue,
            self.color.rawValue,
            self.shading.rawValue
        ]
    }
}
