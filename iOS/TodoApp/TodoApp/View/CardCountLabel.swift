//
//  CardCountLabel.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/07.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class CardCountLabel: UILabel {
    private var cornerRadiusValue: CGFloat {
        return self.frame.height * 0.5
    }
    
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
        self.layer.cornerRadius = cornerRadiusValue
        self.layer.masksToBounds = true
    }
}
