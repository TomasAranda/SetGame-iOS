//
//  SetGame.swift
//  Set Game
//
//  Created by Tomás Aranda on 01/12/2021.
//

import Foundation

struct SetGame {
    private(set) var cards: Array<Card>
    
    struct Card {
        let number: Int
        let shape: String
        let color: String
        let shading: String
    }
}

enum CardVariant: Int, CaseIterable {
    case one = 1, two, three
}

