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
        todoTableView.dragDelegate = self
        todoTableView.dropDelegate = self
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
    
    private func networkErrorAlert(with message: String) {
        let alert = UIAlertController(title: message, message: "서버에 문제가 생겼나봐요!😰", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
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
            TodoNetworkManager.editCardRequest(card: card) { card in
                guard let card = card else {
                    self.networkErrorAlert(with: "카드 수정 실패!")
                    return
                }
                self.manager.replaceCard(at: selectedIndex, with: card)
            }
        }
    }
    
    @IBAction func addCardButtonTabbed(_ sender: AddCardButton) {
        let newCard = Card(id: 0, categoryId: manager.id, title: "", author: "nigayo", contents: "", createdDate: "", modifiedDate: "")
        presentEditingCardViewController(with: newCard) { card in
            TodoNetworkManager.addCardRequest(card: card) { card in
                guard let card = card else {
                    self.networkErrorAlert(with: "카드 추가 실패!")
                    return
                }
                self.manager.insertCard(with: card)
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
        DispatchQueue.main.async {
            self.todoTableView.reloadRows(at: [indexPath], with: .automatic)
        }
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
            TodoNetworkManager.deleteCardRequest(card: selectedCard) { result in
                guard result else {
                    self.networkErrorAlert(with: "카드 삭제 실패!")
                    return
                }
                self.manager.removeCard(at: indexPath)
            }
        })
        return UISwipeActionsConfiguration(actions:[deleteAction])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let moveToDone = self.moveToDoneAction(indexPath: indexPath)
            let edit = self.editAction(indexPath: indexPath)
            let delete = self.deleteAction(indexPath: indexPath)
            return self.manager.id == 3 ? UIMenu(title: "", children: [edit, delete]) : UIMenu(title: "", children: [moveToDone, edit, delete])
        })
    }
    
    private func moveToDoneAction(indexPath: IndexPath) -> UIAction {
        let title = "Move to done"
        let image = UIImage(systemName: "paperplane")
        return UIAction(title: title, image: image) { _ in
            let card = self.manager.getCard(with: indexPath.row)
            TodoNetworkManager.moveCardRequest(card: card, category: 3, index: 0) { card in
                guard let card = card else {
                    self.networkErrorAlert(with: "카드 이동 실패!")
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                    self.manager.removeCard(at: indexPath)
                    NotificationCenter.default.post(name: TodoViewController.moveToDone, object: nil, userInfo: [TodoViewController.moveToDone: card])
                }
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
            TodoNetworkManager.deleteCardRequest(card: selectedCard) { result in
                guard result else {
                    self.networkErrorAlert(with: "카드 삭제 실패!")
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                    self.manager.removeCard(at: indexPath)
                }
            }
        }
    }
}

extension TodoViewController: UITableViewDragDelegate ,UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let card = manager.getCard(with: indexPath.row)
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = card
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        guard let card = coordinator.items.first?.dragItem.localObject as? Card else { return }
        TodoNetworkManager.moveCardRequest(card: card, category: manager.id, index: destinationIndexPath.row) { card in
            guard let card = card else { return }
            self.manager.insertCard(at: destinationIndexPath, with: card)
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
