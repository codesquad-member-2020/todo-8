//
//  TodoViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit


class TodoViewController: UIViewController {
    @IBOutlet weak var cardCountLabel: CardCountLabel!
    @IBOutlet weak var columnTitleLabel: UILabel!
    @IBOutlet weak var todoTableView: UITableView!
    
    private var manager: ColumnManager!
    private(set) var todoTableViewDataSource: TodoTableViewDataSource!
    private var todoTableViewDelegate: TodoTableViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableViewDataSource = TodoTableViewDataSource(presentingViewController: self)
        todoTableView.dataSource = todoTableViewDataSource
        todoTableViewDelegate = TodoTableViewDelegate(presentingViewController: self)
        todoTableView.delegate = todoTableViewDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCardCountLabel), name: NSNotification.Name.init("cardChanged"), object: nil)
    }
    
    func updateColumnData(_ column: Column?) {
        guard let column = column else { return }
        let id = column.id
        let title = column.title
        let cards = column.cards
        
        manager = ColumnManager(id: id, title: title, cards: cards)
        
        todoTableViewDataSource.updateCards(manager!.task)
        todoTableViewDelegate.updateCards(manager!.task)
        DispatchQueue.main.async {
            self.updateColumnTitleLabel(self.manager.title)
            self.updateCardCountLabel()
            self.todoTableView.reloadData()
        }
    }
    
    
    @objc private func updateCardCountLabel() {
        cardCountLabel.text = manager.cardCount()
    }
    
    private func updateColumnTitleLabel(_ title: String?) {
        columnTitleLabel.text = title
    }
    
    @IBAction func addCardButtonTabbed(_ sender: AddCardButton) {
        guard let editingCardViewController = storyboard?.instantiateViewController(identifier: EditingCardViewController.identifier) as? EditingCardViewController else { return }
        let newCard = Card(id: 0, title: "", author: "iOS", contents: "", createdDate: "", modifiedDate: "")
        editingCardViewController.setContents(newCard)
        present(editingCardViewController, animated: true) {
            editingCardViewController.setCompletion({ card in
                self.todoTableViewDataSource.addCard(card)
            })
        }
    }
}

extension TodoViewController: PresentingViewController {
    enum Changes {
        case add, replace, remove
    }

    func presentEditingCardView(with card: Card?, selectedIndex: IndexPath) {
        guard let editingCardViewController = storyboard?.instantiateViewController(identifier: EditingCardViewController.identifier) as? EditingCardViewController else { return }
        editingCardViewController.setContents(card)
        present(editingCardViewController, animated: true) {
            editingCardViewController.setCompletion({ card in
                self.todoTableViewDataSource.replaceCard(selectedIndex, with: card)
            })
        }
    }
    
    func cardChanged(_ changes: Changes, indexPath: IndexPath) {
        switch changes {
        case .add:
            self.todoTableView.insertRows(at: [indexPath], with: .automatic)
        case .remove:
            self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
        case .replace:
            self.todoTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
