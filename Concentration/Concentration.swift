//
//  Concentration.swift
//  Concentration
//
//  Created by Greg Weiss on 6/1/18.
//  Copyright © 2018 Greg Weiss. All rights reserved.
//

import Foundation

class Concentration {
    
   // Try making Concentration a struct and see how the func's need the keyword mutating
    
  private(set) var cards = [Card]()
    
  private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
   public func chooseCard(at index: Int) {
    assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init \(numberOfPairsOfCards): must have at least 1 pair of cards")

        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        randomizeCards()
    }
    
    private func randomizeCards() {
        for _ in 0...cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let randomCard = cards[randomIndex]
            cards.insert(randomCard, at: 0)
            cards.remove(at: randomIndex + 1)
        }
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
