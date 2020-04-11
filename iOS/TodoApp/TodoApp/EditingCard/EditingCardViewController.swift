//
//  EditingCardViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class EditingCardViewController: UIViewController {
    private var contentTextViewDelegate: ContentTextViewDelegate!
    private var titleTextFieldDelegate: TitleTextFieldDelegate!
    var completion: (Card) -> () = { _ in }
    
    private var textViewIsValid = false
    private var textFieldIsValid = false
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: ContentTextView!
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextViewDelegate = ContentTextViewDelegate(bind: { result in
            self.textViewIsValid = result
            self.check()
        })
        titleTextFieldDelegate = TitleTextFieldDelegate(bind: { result in
            self.textFieldIsValid = result
            self.check()
        })
        contentTextView.delegate = contentTextViewDelegate
        titleTextField.delegate = titleTextFieldDelegate
        titleTextField.becomeFirstResponder()
        completeButton.isEnabled = false
    }
    
    private func check() {
        guard textViewIsValid, textFieldIsValid else {
            completeButton.isEnabled = false
            return
        }
        completeButton.isEnabled = true
    }
    
    @IBAction func cancelButtonTabbed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeButtonTabbed(_ sender: UIButton) {
        guard let title = titleTextField.text,
            let content = contentTextView.text else { return }
        let card = Card(id: 0, title: title, author: "iOS", contents: content, createdDate: "", modifiedDate: "")
        dismiss(animated: true) {
            self.completion(card)
        }
    }
}
