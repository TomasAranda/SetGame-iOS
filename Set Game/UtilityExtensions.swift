//
//  UtilityExtensions.swift
//  Set Game
//
//  Created by Tomás Aranda on 21/02/2022.
//

import Foundation
import SwiftUI

// Static function that creates all the cards in a SetGame deck contemplating all the possible unique combinations of attributes
extension SetGame {
    static func generateCardDeck() -> Array<Card> {
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

// Returns card attributes as an array of raw values
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

// Custom animation for card dealing effect
extension Animation {
    static func setGameDealAnimation(for cardIndex: Int) -> Animation {
        var delay = 0.0
        
        if(cardIndex < 12) {
            delay = Double(cardIndex) * (1.0 / 12.0)
        } else {
            delay = Double((cardIndex % 3) + 1) * (0.5 / 3.0)
        }
        
        return Animation.easeInOut(duration: 0.5).delay(delay)
    }
}
