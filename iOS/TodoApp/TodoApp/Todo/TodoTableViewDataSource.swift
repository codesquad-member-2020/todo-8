//
//  TodoTableViewDataSource.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/09.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class TodoTableViewDataSource: NSObject, UITableViewDataSource {
    private var cards: [Card]? {
        didSet {
            cardsChanged("\(cards?.count ?? 0)")
        }
    }
    private var cardsChanged: (String) -> () = { _ in }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseIdentifier) as? TodoCell,
            let cards = cards else {
                return TodoCell()
        }
        let card = cards[indexPath.row]
        cell.configure(with: card)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cards?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func updateCards(_ cards: [Card]?) {
        self.cards = cards
    }
    
    func updateNotify(changed: @escaping (String) -> ()) {
        self.cardsChanged = changed
    }
    
    func addCard(_ card: Card) {
        self.cards?.insert(card, at: 0)
    }
    
    func removeCard(at index: Int) {
        self.cards?.remove(at: index)
    }
}
