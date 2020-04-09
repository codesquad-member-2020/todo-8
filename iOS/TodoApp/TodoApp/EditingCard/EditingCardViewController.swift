//
//  EditingCardViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class EditingCardViewController: UIViewController {
    private let contentTextViewDelegate = ContentTextViewDelegate()
    
    @IBOutlet weak var contentTextView: ContentTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = contentTextViewDelegate
    }
    
    @IBAction func cancelButtonTabbed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
