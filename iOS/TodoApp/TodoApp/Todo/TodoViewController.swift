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
    
    private var columnData: Column? {
        didSet {
            DispatchQueue.main.async {
                self.updateColumnTitleLabel(self.columnData?.title)
            }
            dataSource.updateCards(columnData?.cards)
        }
    }
    private let dataSource = TodoTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = dataSource
        dataSource.updateNotify { count in
            DispatchQueue.main.async {
                self.updateCardCountLabel(count)
                self.todoTableView.reloadData()
            }
        }
    }
    
    func updateColumnData(_ column: Column?) {
        columnData = column
    }
    
    private func updateCardCountLabel(_ count: String?) {
        cardCountLabel.text = count
    }
    
    private func updateColumnTitleLabel(_ title: String?) {
        columnTitleLabel.text = title
    }
}
