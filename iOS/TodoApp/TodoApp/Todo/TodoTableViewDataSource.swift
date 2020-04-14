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
    private var task: Task?
    
    init(presentingViewController: PresentingViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task?.cards.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseIdentifier) as? TodoCell,
            let task = task else {
                return TodoCell()
        }
        let card = task.cards[indexPath.row]
        cell.configure(with: card)
        return cell
    }
    
    func updateCards(_ task: Task) {
        self.task = task
    }
    
    func addCard(_ card: Card) {
        self.task?.cards.insert(card, at: 0)
        presentingViewController.cardChanged(.add, indexPath: IndexPath(row: 0, section: 0))
    }
    
    func replaceCard(_ index: IndexPath, with card: Card) {
        self.task?.cards[index.row] = card
        presentingViewController.cardChanged(.replace, indexPath: index)
    }
}

extension TodoTableViewDataSource {
    func removeCard(at index: IndexPath) {
        self.task?.cards.remove(at: index.row)
        presentingViewController.cardChanged(.remove, indexPath: index)
    }
    
    func getCard(at index: IndexPath) -> Card? {
        return self.task?.cards[index.row]
    }
}
