//
//  Card.swift
//  Concentration.naggirk
//
//  Created by Robin Naggi on 1/3/19.
//  Copyright © 2019 Robin Naggi. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueidentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueidentifier()
    }
}
