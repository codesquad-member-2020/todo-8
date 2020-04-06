//
//  CardCountLabel.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class CardCountLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setProperties()
    }
    
    private func setProperties() {
        self.backgroundColor = .white
        self.textAlignment = .center
        self.layer.cornerRadius = self.frame.height * 0.5
        self.layer.masksToBounds = true
    }
}
