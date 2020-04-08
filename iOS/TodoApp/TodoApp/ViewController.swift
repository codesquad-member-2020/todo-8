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
    }
}
