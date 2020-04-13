//
//  TodoTableViewDataSource.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/09.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class TodoTableViewDataSource: NSObject, UITableViewDataSource {
    private let presentingViewController: PresentingViewController
    private var cards: [Card]? {
        didSet {
            cardsChanged("\(cards?.count ?? 0)")
        }
    }
    private var cardsChanged: (String) -> () = { _ in }
    
    init(presentingViewController: PresentingViewController) {
        self.presentingViewController = presentingViewController
    }
    
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
            removeCard(at: indexPath)
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
        presentingViewController.cardChanged(.add, indexPath: IndexPath(row: 0, section: 0))
    }
    
    func replaceCard(_ index: IndexPath, with card: Card) {
        self.cards?[index.row] = card
        presentingViewController.cardChanged(.replace, indexPath: index)
    }
}

extension TodoTableViewDataSource: LinkedDataSource {
    func removeCard(at index: IndexPath) {
        self.cards?.remove(at: index.row)
        presentingViewController.cardChanged(.remove, indexPath: index)
    }
    
    func getCard(at index: IndexPath) -> Card? {
        return self.cards?[index.row]
    }
}
