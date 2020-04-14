//
//  TodoTableViewDelegate.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/13.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

protocol PresentingViewController {
    func presentEditingCardView(with: Card?, selectedIndex: IndexPath)
    func cardChanged(_ changes: TodoViewController.Changes, indexPath: IndexPath)
}

class TodoTableViewDelegate: NSObject, UITableViewDelegate {
    static let moveToDone = NSNotification.Name.init("moveToDone")
    private let presentingViewController: PresentingViewController
    private var task: Task?
    
    init(presentingViewController: PresentingViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.task?.cards.remove(at: indexPath.row)
            self.presentingViewController.cardChanged(.remove, indexPath: indexPath)
            success(true)
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
    
    func moveToDoneAction(indexPath: IndexPath) -> UIAction {
        let title = "Move to done"
        let image = UIImage(systemName: "paperplane")
        return UIAction(title: title, image: image) { _ in
            guard let card = self.task?.cards[indexPath.row] else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                self.task?.cards.remove(at: indexPath.row)
                self.presentingViewController.cardChanged(.remove, indexPath: indexPath)
            }
            NotificationCenter.default.post(name: TodoTableViewDelegate.moveToDone, object: nil, userInfo: [TodoTableViewDelegate.moveToDone:card])
        }
    }
    
    func editAction(indexPath: IndexPath) -> UIAction {
        let title = "Edit"
        let image = UIImage(systemName: "pencil.and.outline")
        return UIAction(title: title, image: image) { _ in
            self.presentingViewController.presentEditingCardView(with: self.task?.cards[indexPath.row], selectedIndex: indexPath)
        }
    }
    
    func deleteAction(indexPath: IndexPath) -> UIAction {
        let title = "Delete"
        let image = UIImage(systemName: "trash")
        return UIAction(title: title, image: image, attributes: .destructive) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                self.task?.cards.remove(at: indexPath.row)
                self.presentingViewController.cardChanged(.remove, indexPath: indexPath)
            }
        }
    }
    
    func updateCards(_ task: Task) {
        self.task = task
    }
}
