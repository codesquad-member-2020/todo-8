//
//  TodoViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDataSource {
    var cards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.cardCountLabel.text = "\(self.cards.count)"
                self.todoTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var cardCountLabel: CardCountLabel!
    @IBOutlet weak var columnTitleLabel: UILabel!
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseIdentifier) as? TodoCell else {
            return TodoCell()
        }
        let card = cards[indexPath.row]
        cell.configure(title: card.title, content: card.contents, author: card.author)
        return cell
    }
}
