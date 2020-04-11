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
    private var title = "" {
        didSet {
            checkCondition()
        }
    }
    private var content = "" {
        didSet {
            checkCondition()
        }
    }
    private var buttonIsEnabled = false {
        didSet {
            textChanged(buttonIsEnabled)
        }
    }
    private var textChanged: (Bool) -> ()
    
    init(bind closure: @escaping (Bool) -> ()) {
        self.textChanged = closure
    }

    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setContent(_ content: String) {
        self.content = content
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
