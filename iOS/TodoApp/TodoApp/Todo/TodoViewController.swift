//
//  TodoViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var cardCountLabel: CardCountLabel!
    @IBOutlet weak var columnTitleLabel: UILabel!
    @IBOutlet weak var todoTableView: UITableView!
    
    private let dataSource = TodoTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = dataSource
        todoTableView.delegate = self
        dataSource.updateNotify { count in
            DispatchQueue.main.async {
                self.updateCardCountLabel(count)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in

            let moveToDone = UIAction(title: "Move to done", image: UIImage(systemName: "paperplane")) { _ in

            }
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil.and.outline")) { _ in
                
            }
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            }
            return UIMenu(title: "", children: [moveToDone, edit, delete])
        })
    }
    
    func updateColumnData(_ column: Column?) {
        dataSource.updateCards(column?.cards)
        DispatchQueue.main.async {
            self.updateColumnTitleLabel(column?.title)
            self.todoTableView.reloadData()
        }
    }
    
    private func updateCardCountLabel(_ count: String?) {
        cardCountLabel.text = count
    }
    
    private func updateColumnTitleLabel(_ title: String?) {
        columnTitleLabel.text = title
    }
    
    @IBAction func addCardButtonTabbed(_ sender: AddCardButton) {
        guard let editingCardViewController = storyboard?.instantiateViewController(identifier: "edit") as? EditingCardViewController else { return }
        present(editingCardViewController, animated: true) {
            editingCardViewController.setCompletion({ card in
                self.dataSource.addCard(card)
                self.todoTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            })
        }
    }
}
