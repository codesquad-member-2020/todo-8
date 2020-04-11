//
//  TitleTextFieldDelegate.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/11.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class TitleTextFieldDelegate: NSObject, UITextFieldDelegate {
    private var isValid: (Bool) -> ()
    
    init(bind closure: @escaping (Bool) -> ()) {
        self.isValid = closure
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isValid(!textField.text!.isEmpty)
    }
}
