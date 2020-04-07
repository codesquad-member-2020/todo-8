//
//  EditingCardViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class EditingCardViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var contentTextView: ContentTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            DispatchQueue.main.async {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textView = textView as? ContentTextView,
            textView.text.count + (text.count - range.length) <= 500 else { return false }
        let updatedText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if updatedText.isEmpty {
            textView.setPlaceholder()
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else if textView.textColor == .placeholderText && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        } else {
            return true
        }
        return false
    }
}
