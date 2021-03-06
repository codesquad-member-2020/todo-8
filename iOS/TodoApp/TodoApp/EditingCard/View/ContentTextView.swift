//
//  ContentTextView.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ContentTextView: UITextView {
    static let placeholder = "Content"
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setProperties()
    }

    private func setProperties() {
        self.autocorrectionType = .no
    }
    
    func setPlaceholder() {
        self.text = ContentTextView.placeholder
        self.textColor = .placeholderText
    }
}
