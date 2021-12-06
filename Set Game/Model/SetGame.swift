//
//  SetGame.swift
//  Set Game
//
//  Created by Tomás Aranda on 01/12/2021.
//

import Foundation

struct SetGame {
    private(set) var cards: Array<Card>
    
    private var selectedCards: Array<Card> {
        get { cards.filter { $0.isSelected } }
    }
    
    init (cards: Array<Card>) {
        self.cards = SetGame.generateCardDeck()
    }
    
    // select card
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards[choosenIndex].isSelected = true
        }
    }
        
    static func isSet(cards: Array<Card>) -> Bool {
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
        
        for number in CardAttributeVariant.allCases {
            for shape in CardAttributeVariant.allCases {
                for color in CardAttributeVariant.allCases {
                    for shading in CardAttributeVariant.allCases {
                        deck.append(Card(
                            id: 1,
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
        
        return deck
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
