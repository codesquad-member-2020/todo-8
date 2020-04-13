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

protocol LinkedDataSource {
    func removeCard(at: IndexPath)
    func getCard(at: IndexPath) -> Card?
}

class TodoTableViewDelegate: NSObject, UITableViewDelegate {
    static let moveToDone = NSNotification.Name.init("moveToDone")
    private let presentingViewController: PresentingViewController
    private let dataSource: LinkedDataSource
    
    init(presentingViewController: PresentingViewController, dataSource: LinkedDataSource) {
        self.presentingViewController = presentingViewController
        self.dataSource = dataSource
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let moveToDone = UIAction(title: "Move to done", image: UIImage(systemName: "paperplane")) { _ in
                guard let card = self.dataSource.getCard(at: indexPath) else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                    self.dataSource.removeCard(at: indexPath)
                }
                NotificationCenter.default.post(name: TodoTableViewDelegate.moveToDone, object: nil, userInfo: [TodoTableViewDelegate.moveToDone:card])
            }
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil.and.outline")) { _ in
                self.presentingViewController.presentEditingCardView(with: self.dataSource.getCard(at: indexPath), selectedIndex: indexPath)
            }
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                    self.dataSource.removeCard(at: indexPath)
                }
            }
            return UIMenu(title: "", children: [moveToDone, edit, delete])
        })
    }
}
