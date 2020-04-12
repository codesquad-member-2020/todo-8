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
    private var completion: (Card) -> () = { _ in }
    private var editingViewModel = EditingViewModel()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: ContentTextView!
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if editingViewModel.buttonIsEnabled {
            updateWithViewModel()
        } else {
            contentTextView.setPlaceholder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editingViewModel.updateNotify { isEnabled in
            self.completeButton.isEnabled = isEnabled
        }
        titleTextFieldDelegate = TitleTextFieldDelegate(bind: { title in
            self.editingViewModel.setTitle(title)
        })
        titleTextField.delegate = titleTextFieldDelegate
        contentTextViewDelegate = ContentTextViewDelegate(bind: { content in
            self.editingViewModel.setContent(content)
        })
        contentTextView.delegate = contentTextViewDelegate
        titleTextField.becomeFirstResponder()
        completeButton.isEnabled = false
    }
    
    func setCompletion(_ completion: @escaping (Card) -> ()) {
        self.completion = completion
    }
    
    func setContents(_ card: Card?) {
        guard let card = card else { return }
        editingViewModel.updateData(card)
    }
    
    private func updateWithViewModel() {
        titleTextField.text = editingViewModel.title
        contentTextView.text = editingViewModel.content
    }
    
    @IBAction func cancelButtonTabbed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeButtonTabbed(_ sender: UIButton) {
        let card = editingViewModel.convertToCard()
        dismiss(animated: true) {
            self.completion(card)
        }
    }
}
