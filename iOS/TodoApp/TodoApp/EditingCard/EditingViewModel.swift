//
//  EditingViewModel.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/11.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class EditingViewModel {
    private let placeholderText = ContentTextView.placeholder
    private(set) var title = "" {
        didSet {
            checkCondition()
        }
    }
    private(set) var content = "" {
        didSet {
            checkCondition()
        }
    }
    private(set) var buttonIsEnabled = false {
        didSet {
            textChanged(buttonIsEnabled)
        }
    }
    private var textChanged: (Bool) -> () = { _ in }

    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setContent(_ content: String) {
        self.content = content
    }
    
    func updateNotify(_ handler: @escaping (Bool) -> ()) {
        self.textChanged = handler
    }
    
    func updateData(_ card: Card) {
        title = card.title
        content = card.contents
    }
    
    func convertToCard() -> Card {
        return Card(id: 0, title: title, author: "iOS", contents: content, createdDate: "", modifiedDate: "")
    }
    
    private func checkCondition() {
        guard !title.isEmpty, !content.isEmpty, content != placeholderText else {
            buttonIsEnabled = false
            return
        }
        buttonIsEnabled = true
    }
}
