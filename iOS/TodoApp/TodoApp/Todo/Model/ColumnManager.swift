//
//  ColumnManager.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/14.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class ColumnManager {
    var id: Int
    var title: String
    var task: Task
    
    init(id: Int, title: String, cards: [Card]) {
        self.id = id
        self.title = title
        self.task =  Task.init(cards: cards)
    }
    
    func cardCount() -> String {
        return "\(task.cards.count)"
    }
}

class Task {
    var cards: [Card] {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name.init("cardChanged"), object: nil)
        }
    }
    
    init(cards: [Card]) {
        self.cards = cards
    }
}
