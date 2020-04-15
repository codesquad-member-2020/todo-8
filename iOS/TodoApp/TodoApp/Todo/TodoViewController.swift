//
//  TodoViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
    static let moveToDone = NSNotification.Name.init("moveToDone")
    
    @IBOutlet weak var cardCountLabel: CardCountLabel!
    @IBOutlet weak var columnTitleLabel: UILabel!
    @IBOutlet weak var todoTableView: UITableView!
    
    private var manager: ColumnManager! {
        didSet {
            todoTableViewDataSource.updateCards(manager?.task)
            addObservers()
        }
    }
    private var todoTableViewDataSource: TodoTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableViewDataSource = TodoTableViewDataSource()
        todoTableView.dataSource = todoTableViewDataSource
        todoTableView.delegate = self
    }
    
    func addCard(_ card: Card) {
        manager.insertCard(with: card)
    }
    
    func updateColumnData(_ column: Column?) {
        guard let column = column else { return }
        let id = column.id
        let title = column.title
        let cards = column.cards
        
        manager = ColumnManager(id: id, title: title, cards: cards)
        
        DispatchQueue.main.async {
            self.updateColumnTitleLabel(self.manager.title)
            self.updateCardCountLabel()
            self.todoTableView.reloadData()
        }
    }
    
    private func updateColumnTitleLabel(_ title: String?) {
        columnTitleLabel.text = title
    }
    
    private func presentEditingCardViewController(with card: Card?, completion: @escaping (Card) -> ()) {
        guard let editingCardViewController = storyboard?.instantiateViewController(identifier: EditingCardViewController.identifier) as? EditingCardViewController else { return }
        editingCardViewController.setContents(card)
        present(editingCardViewController, animated: true) {
            editingCardViewController.setCompletion(completion)
        }
    }
    
    private func editCard(_ card: Card?, selectedIndex: IndexPath) {
        presentEditingCardViewController(with: card) { card in
            self.manager.replaceCard(at: selectedIndex, with: card)
        }
    }
    
    @IBAction func addCardButtonTabbed(_ sender: AddCardButton) {
        let newCard = Card(id: 0, categoryId: manager.id, title: "", author: "nigayo", contents: "", createdDate: "", modifiedDate: "")
        presentEditingCardViewController(with: newCard) { card in
            let data = ["categoryId": "\(card.categoryId)", "author": card.author, "title": card.title, "contents": card.contents]
            let body = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            NetworkManager.httpRequest(url: NetworkManager.serverUrl + "cards", method: .POST, body: body) { (data, response, error) in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let responseCard = try decoder.decode(Response.self, from: data)
                    if responseCard.success {
                        self.manager.insertCard(with: responseCard.response)
                    }
                } catch {

                }
            }
        }
    }
}

extension TodoViewController {
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(cardAdded(_:)), name: ColumnManager.cardInserted, object: manager)
        NotificationCenter.default.addObserver(self, selector: #selector(cardRemoved(_:)), name: ColumnManager.cardRemoved, object: manager)
        NotificationCenter.default.addObserver(self, selector: #selector(cardReplaced(_:)), name: ColumnManager.cardReplaced, object: manager)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCardCountLabel), name: Task.cardChanged, object: nil)
    }
        
    @objc private func cardAdded(_ notification: NSNotification) {
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        DispatchQueue.main.async {
            self.todoTableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc private func cardRemoved(_ notification: NSNotification) {
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        DispatchQueue.main.async {
            self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc private func cardReplaced(_ notification: NSNotification) {
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        self.todoTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc private func updateCardCountLabel() {
        DispatchQueue.main.async {
            self.cardCountLabel.text = self.manager.cardCount()
        }
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let title = "Delete"
        let deleteAction = UIContextualAction(style: .destructive, title: title, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let selectedCard = self.manager.getCard(with: indexPath.row)
            NetworkManager.httpRequest(url: NetworkManager.serverUrl + "cards/" + "\(selectedCard.id)", method: .DELETE) { (data, _, _) in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(Response.self, from: data)
                    if data.success {
                        self.manager.removeCard(at: indexPath)
                    }
                } catch {
                    
                }
            }
        })
        return UISwipeActionsConfiguration(actions:[deleteAction])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let moveToDone = self.moveToDoneAction(indexPath: indexPath)
            let edit = self.editAction(indexPath: indexPath)
            let delete = self.deleteAction(indexPath: indexPath)
            return UIMenu(title: "", children: [moveToDone, edit, delete])
        })
    }
    
    private func moveToDoneAction(indexPath: IndexPath) -> UIAction {
        let title = "Move to done"
        let image = UIImage(systemName: "paperplane")
        return UIAction(title: title, image: image) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                let card = self.manager.getCard(with: indexPath.row)
                self.manager.removeCard(at: indexPath)
                NotificationCenter.default.post(name: TodoViewController.moveToDone, object: nil, userInfo: [TodoViewController.moveToDone: card])
            }
        }
    }
    
    private func editAction(indexPath: IndexPath) -> UIAction {
        let title = "Edit"
        let image = UIImage(systemName: "pencil.and.outline")
        return UIAction(title: title, image: image) { _ in
            let card = self.manager.getCard(with: indexPath.row)
            self.editCard(card, selectedIndex: indexPath)
        }
    }
    
    private func deleteAction(indexPath: IndexPath) -> UIAction {
        let title = "Delete"
        let image = UIImage(systemName: "trash")
        return UIAction(title: title, image: image, attributes: .destructive) { _ in
            let selectedCard = self.manager.getCard(with: indexPath.row)
            NetworkManager.httpRequest(url: NetworkManager.serverUrl + "cards/" + "\(selectedCard.id)", method: .DELETE) { (data, _, _) in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let card = try decoder.decode(Card.self, from: data)
                    if selectedCard == card {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                            self.manager.removeCard(at: indexPath)
                        }
                    }
                } catch {
                    
                }
            }
        }
    }
}
