//
//  AddCardButton.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class AddCardButton: UIButton {
    private let plusImage = UIImage(systemName: "plus")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setProperties()
    }
    
    private func setProperties() {
        self.setImage(plusImage, for: .normal)
        self.tintColor = .black
    }
}
