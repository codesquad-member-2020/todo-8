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
    private(set) var card: Card? {
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
        self.card?.title = title
    }
    
    func setContent(_ content: String) {
        self.card?.contents = content
    }
    
    func updateNotify(_ handler: @escaping (Bool) -> ()) {
        self.textChanged = handler
    }
    
    func updateData(_ card: Card) {
        self.card = card
    }
    
    private func checkCondition() {
        guard let card = card,
            !card.title.isEmpty,
            !(card.contents?.isEmpty ?? false),
            card.contents != placeholderText else {
                buttonIsEnabled = false
                return
        }
        buttonIsEnabled = true
    }
}
