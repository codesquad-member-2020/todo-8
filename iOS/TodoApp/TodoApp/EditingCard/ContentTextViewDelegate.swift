//
//  ContentTextViewDelegate.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/09.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ContentTextViewDelegate: NSObject, UITextViewDelegate {
    private let contentCharactorCountLimit = 500
    
    private func beginning(of textView: UITextView) -> UITextRange? {
        let beginningPoint = textView.beginningOfDocument
        return textView.textRange(from: beginningPoint, to: beginningPoint)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        DispatchQueue.main.async {
            textView.selectedTextRange = self.beginning(of: textView)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textView = textView as? ContentTextView,
            textView.text.count + (text.count - range.length) <= contentCharactorCountLimit else { return false }
        let updatedText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if updatedText.isEmpty {
            textView.setPlaceholder()
            textView.selectedTextRange = beginning(of: textView)
        } else if textView.textColor == .placeholderText && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        } else {
            return true
        }
        return false
    }
}
