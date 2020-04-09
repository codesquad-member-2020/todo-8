//
//  ViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/06.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum Identifier: String {
        case todo = "1"
        case progressing = "2"
        case complete = "3"
        
        func isValid(identifier: String?, completion: ()->() ) {
            if identifier == rawValue {
                completion()
            }
        }
    }
    
    private var todoViewController: TodoViewController?
    private var progressingViewController: TodoViewController?
    private var completeViewController: TodoViewController?
    private let dataManager = DataManager()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Identifier.todo.isValid(identifier: segue.identifier) {
            self.todoViewController = segue.destination as? TodoViewController
        }
        Identifier.progressing.isValid(identifier: segue.identifier) {
            self.progressingViewController = segue.destination as? TodoViewController
        }
        Identifier.complete.isValid(identifier: segue.identifier) {
            self.completeViewController = segue.destination as? TodoViewController
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        dataManager.loadData()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: DataManager.dataDidLoad, object: nil)
    }
    
    @objc private func updateData() {
        todoViewController?.updateColumnData(self.dataManager.data(of: Identifier.todo.rawValue))
        progressingViewController?.updateColumnData(self.dataManager.data(of: Identifier.progressing.rawValue))
        completeViewController?.updateColumnData(self.dataManager.data(of: Identifier.complete.rawValue))
    }
}
