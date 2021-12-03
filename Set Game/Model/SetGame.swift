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
    
    // select card
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards[choosenIndex].isSelected = true
        }
    }
        
    struct Card: Identifiable {
        var id: Int
        let attributes: CardAttributes
        
        var isSelected = false
        var isMatched = false
        
        static func match(cards: Array<Card>) -> Bool {
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
    }

    struct CardAttributes {
        let number: CardAttributeVariant
        let shape: CardAttributeVariant
        let color: CardAttributeVariant
        let shading: CardAttributeVariant
        
        func toArrayOfRawValues() -> [Int] {
            return [
                self.number.rawValue,
                self.shape.rawValue,
                self.color.rawValue,
                self.shading.rawValue
            ]
        }
    }
}

enum CardAttributeVariant: Int, CaseIterable {
    case one = 1, two, three
}

