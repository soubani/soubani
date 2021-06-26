//
//  DataPickerAdapter.swift
//  Umniah_eWallet
//
//  Created by Mohammad Farhan on 10/25/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

public final class DataPickerAdapter: NSObject {
    
    private let textField: UITextField
    private lazy var pickerView: UIPickerView = {
        UIPickerView()
    }()
    
    private var items = [String]() {
        didSet { pickerView.reloadAllComponents() }
    }
    
    private(set) var selectedIndex: Int?
    public var selectionHandler: ((Int) -> Void)?
    
    public  init(textField: UITextField) {
        self.textField = textField
        super.init()
        setup()
    }
    
    public  func set(items: [String]) {
        self.items = items
        pickerView(pickerView, didSelectRow: .zero, inComponent: .zero)
    }
    
    private func setup() {
        pickerView.dataSource = self
        pickerView.delegate = self
        textField.delegate = self
        textField.inputView = pickerView
    }
    
}

// MARK: - UITextFieldDelegate

 extension DataPickerAdapter: UITextFieldDelegate {
    public  func textFieldDidEndEditing(_ textField: UITextField) {
        guard selectedIndex == nil else { return }
        textField.text = items[safe: 0]
        selectionHandler?(0)
    }
}

// MARK: - UIPickerViewDataSource

 extension DataPickerAdapter: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
}

// MARK: - UIPickerViewDelegate

extension DataPickerAdapter: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = items[safe: row]
        return item
    }
    
    public  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = items[safe: row]
        textField.text = item
        selectedIndex = row
        selectionHandler?(row)
    }
}

extension DataPickerAdapter {
    public  func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return false
    }
}
