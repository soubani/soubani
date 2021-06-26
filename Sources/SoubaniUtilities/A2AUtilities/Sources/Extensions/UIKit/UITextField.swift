//
//  UITextField.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/21/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

private var maxTextFieldLengths = [UITextField: Int]()
public extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxTextFieldLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return length
        }
        set {
            maxTextFieldLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc
    func fix(textField: UITextField) {
        let field = textField.text
        textField.text = field?.prefix(maxLength).description
    }
}

public extension UITextField {
    func value(range: NSRange, string: String) -> String {
        guard let textValue = text as NSString? else { return "" }
        let text = (textValue.replacingCharacters(in: range, with: string)).defaultIfEmpty
        return text
    }
    
    func showPassword() {
        isSecureTextEntry.toggle()
    }
}
public extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
