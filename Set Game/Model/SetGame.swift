//
//  SetGame.swift
//  Set Game
//
//  Created by Tomás Aranda on 01/12/2021.
//

import Foundation

struct SetGame {
    private(set) var cards: Array<Card>
    private var indicesOfSelectedCards = Array<Int>()
    
    init () {
        self.cards = SetGame.generateCardDeck()
    }
    
    // select card
    mutating func choose(_ card: Card) {
        if let choosenCardId = cards.firstIndex(where: { $0.id == card.id }),
           !cards[choosenCardId].isMatched {
            if indicesOfSelectedCards.count < 3 {
                if cards[choosenCardId].isSelected {
                    // deselection of card already selected
                    indicesOfSelectedCards.remove(at: indicesOfSelectedCards.firstIndex(of: cards[choosenCardId].id)!)
                    cards[choosenCardId].isSelected = false
                    return
                }
                // selection
                cards[choosenCardId].isSelected = true
                indicesOfSelectedCards.append(cards[choosenCardId].id)
                if indicesOfSelectedCards.count == 3 {
                    // matching check
                    let arrayOfSelectedCards = cards.filter { indicesOfSelectedCards.contains($0.id) }
                    if SetGame.isSet(ofCards: arrayOfSelectedCards) {
                        cards.indices.forEach {
                            if !cards[$0].isMatched {
                                cards[$0].isMatched = indicesOfSelectedCards.contains($0 + 1)
                            }
                        }
                        cards.indices.forEach { cards[$0].isSelected = false }
                        indicesOfSelectedCards.removeAll()
                    }
                }
            } else if !indicesOfSelectedCards.contains(choosenCardId + 1) {
                // cards.count == 3 && isSet(arrayOfSelectedCards) == false
                cards.indices.forEach { cards[$0].isSelected = false }
                indicesOfSelectedCards.removeAll()
                indicesOfSelectedCards.append(cards[choosenCardId].id)
                cards[choosenCardId].isSelected = true
            }
        }
    }
        
    static func isSet(ofCards cards: Array<Card>) -> Bool {
        guard cards.count == 3 else {
            return false
        }
        
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
    }

    struct CardAttributes {
        let number: CardAttributeVariant
        let shape: CardAttributeVariant
        let color: CardAttributeVariant
        let shading: CardAttributeVariant
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
                            attributes: CardAttributes(
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
        
        return deck/*.shuffled()*/
    }
}

enum CardAttributeVariant: Int, CaseIterable {
    case one = 1, two, three
}

extension SetGame.CardAttributes {
    func toArrayOfRawValues() -> [Int] {
        return [
            self.number.rawValue,
            self.shape.rawValue,
            self.color.rawValue,
            self.shading.rawValue
        ]
    }
}
