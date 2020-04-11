//
//  ContentTextView.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ContentTextView: UITextView {
    private let placeholder = "Content"
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setProperties()
        setPlaceholder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setProperties()
        setPlaceholder()
    }

    private func setProperties() {
        self.autocorrectionType = .no
    }
    
    func setPlaceholder() {
        self.text = placeholder
        self.textColor = .placeholderText
    }
}
