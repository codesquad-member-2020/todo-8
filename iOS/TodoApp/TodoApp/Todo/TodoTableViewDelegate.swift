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
}

protocol LinkedDataSource {
    func removeCard(at: Int)
    func getCard(at: Int) -> Card?
}

class TodoTableViewDelegate: NSObject, UITableViewDelegate {
    private let presentingViewController: PresentingViewController
    private let dataSource: LinkedDataSource
    
    init(presentingViewController: PresentingViewController, dataSource: LinkedDataSource) {
        self.presentingViewController = presentingViewController
        self.dataSource = dataSource
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let moveToDone = UIAction(title: "Move to done", image: UIImage(systemName: "paperplane")) { _ in
            }
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil.and.outline")) { _ in
                self.presentingViewController.presentEditingCardView(with: self.dataSource.getCard(at: indexPath.row), selectedIndex: indexPath)
            }
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.67) {
                    self.dataSource.removeCard(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
            return UIMenu(title: "", children: [moveToDone, edit, delete])
        })
    }
}
