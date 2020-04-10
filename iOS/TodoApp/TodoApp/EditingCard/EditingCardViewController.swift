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
    var completion: (Card) -> () = { _ in }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: ContentTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = contentTextViewDelegate
    }
    
    @IBAction func cancelButtonTabbed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeButtonTabbed(_ sender: UIButton) {
        guard let title = titleTextField.text,
            let content = contentTextView.text else { return }
        let card = Card(id: "", title: title, author: "iOS", contents: content, createdDate: "", modifiedDate: "")
        dismiss(animated: true) {
            self.completion(card)
        }
    }
}
