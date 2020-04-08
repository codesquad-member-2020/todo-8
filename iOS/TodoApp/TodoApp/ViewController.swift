//
//  ViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/06.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var todoViewController: TodoViewController?
    private var progressingViewController: TodoViewController?
    private var completeViewController: TodoViewController?
    private let dataManager = DataManager()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todo" {
            todoViewController = segue.destination as? TodoViewController
        } else if segue.identifier == "progressing" {
            progressingViewController = segue.destination as? TodoViewController
        } else if segue.identifier == "complete" {
            completeViewController = segue.destination as? TodoViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoViewController?.columnTitleLabel.text = "해야할 일"
        self.progressingViewController?.columnTitleLabel.text = "하고있는 일"
        self.completeViewController?.columnTitleLabel.text = "완료한 일"
        dataManager.loadData {
            self.todoViewController?.cards = self.dataManager.data(of: "1")
            self.progressingViewController?.cards = self.dataManager.data(of: "2")
            self.completeViewController?.cards = self.dataManager.data(of: "3")
        }
    }
}
