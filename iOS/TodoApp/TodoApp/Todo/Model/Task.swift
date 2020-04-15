//
//  Task.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/14.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class Task {
    static let cardChanged = NSNotification.Name.init("cardChanged")
    
    private var cards: [Card] {
        didSet {
            NotificationCenter.default.post(name: Task.cardChanged, object: nil)
        }
    }
    var count: Int {
        return cards.count
    }
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func getCard(with index: Int) -> Card {
        return cards[index]
    }
    
    func insert(_ card: Card, at index: Int) {
        cards.insert(card, at: index)
    }
    
    func remove(at index: Int) {
        cards.remove(at: index)
    }
    
    func replace(at index: Int, with card: Card) {
        cards[index] = card
    }
}
