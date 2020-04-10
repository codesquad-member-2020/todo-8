//
//  ViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/06.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        dataManager.loadData()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: DataManager.dataDidLoad, object: nil)
    }
    
    @objc private func updateData() {
        var columnId = 1
        DispatchQueue.main.async {
            self.children.forEach {
                guard let todoViewController = $0 as? TodoViewController else { return }
                todoViewController.updateColumnData(self.dataManager.data(of: columnId))
                columnId += 1
            }
        }
    }
}
