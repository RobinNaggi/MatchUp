//
//  Concentretion.swift
//  Concentration.naggirk
//
//  Created by Robin Naggi on 1/3/19.
//  Copyright © 2019 Robin Naggi. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0 
    var flipCount = 1
    var seenCards = [Int]()
    
    func chooseCard(at index: Int) {
        if seenCards.contains(index) {
            score -= 1
        } else {
            seenCards += [index]
        }
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 3
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                flipCount += 1
            } else {
                // either no cards or 2 cards are face up
                // turn all the cards face down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                flipCount += 1
            }
        } else {
            flipCount += 1
        }
    }
    
    func checkGameWinner() -> Bool {
        var count = 0
        for index in cards {
            if index.isMatched {
                count += 1
            }
        }
        
        if count == 12 {
            return true
        }
        return false
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getFlipCount() -> Int {
        return flipCount
    }
    
    init(numberOfPairsOfCards: Int ) {
        for _ in 0 ..< numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
        cards.shuffle()
    }
}
