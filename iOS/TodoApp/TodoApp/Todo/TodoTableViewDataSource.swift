//
//  TodoTableViewDataSource.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/09.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class TodoTableViewDataSource: NSObject, UITableViewDataSource {
    private var task: Task?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseIdentifier) as? TodoCell,
            let task = task else {
                return TodoCell()
        }
        let card = task.getCard(with: indexPath.row)
        cell.configure(with: card)
        return cell
    }
    
    func updateCards(_ task: Task?) {
        self.task = task
    }
}
