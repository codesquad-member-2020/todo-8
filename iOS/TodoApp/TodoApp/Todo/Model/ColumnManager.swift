//
//  ColumnManager.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/14.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class ColumnManager {
    static let cardInserted = NSNotification.Name.init("cardInserted")
    static let cardRemoved = NSNotification.Name.init("cardRemoved")
    static let cardReplaced = NSNotification.Name.init("cardReplaced")
    
    private(set) var id: Int
    private(set) var title: String
    private(set) var task: Task
    
    init(id: Int, title: String, cards: [Card]) {
        self.id = id
        self.title = title
        self.task =  Task.init(cards: cards)
    }
    
    func cardCount() -> String {
        return "\(task.count)"
    }
    
    func getCard(with index: Int) -> Card {
        return task.getCard(with: index)
    }
    
    func insertCard(at indexPath: IndexPath = IndexPath(row: 0, section: 0), with card: Card) {
        task.insert(card, at: 0)
        NotificationCenter.default.post(name: ColumnManager.cardInserted, object: self, userInfo: ["indexPath": indexPath])
    }
    
    func removeCard(at indexPath: IndexPath) {
        let card = task.remove(at: indexPath.row)
        NotificationCenter.default.post(name: ColumnManager.cardRemoved, object: self, userInfo: ["indexPath": indexPath, "id": card.id])
    }
    
    func replaceCard(at indexPath: IndexPath, with card: Card) {
        task.replace(at: indexPath.row, with: card)
        NotificationCenter.default.post(name: ColumnManager.cardReplaced, object: self, userInfo: ["indexPath": indexPath])
    }
}
