//
//  DatePickerAdapter.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 1/23/21.
//  Copyright © 2021 A2A. All rights reserved.
//

import UIKit

public struct DatePickerProperties {
    public var minimumDate: Date?
    public var maximumDate: Date?
    public var pickerMode: UIDatePicker.Mode = .date
    public var format: DateFormat = .yearMonthDay
    
    public init(
        minimumDate: Date? = nil,
        maximumDate: Date? = Date(),
        pickerMode: UIDatePicker.Mode = .date,
        format: DateFormat = .yearMonthDay
    ) {
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.pickerMode = pickerMode
        self.format = format
    }
}

public final class DatePickerAdapter: NSObject {

    private lazy var datePicker = UIDatePicker()
    private let textField: UITextField
    public var properties: DatePickerProperties {
        didSet { setupProperties() }
    }
    private(set) var date: Date?
    
    public var dateHandler: ((Date) -> Void)?
    
    public init(textField: UITextField, properties: DatePickerProperties = DatePickerProperties()) {
        self.textField = textField
        self.properties = properties
        super.init()
        setup()
    }
    
    private func setup() {
        textField.delegate = self
        textField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        textField.text = properties.maximumDate?.toString(format: properties.format)
        setupProperties()
    }
    
    private func setupProperties() {
        datePicker.datePickerMode = properties.pickerMode
        datePicker.minimumDate = properties.minimumDate
        datePicker.maximumDate = properties.maximumDate
    }
}

// MARK: - UITextFieldDelegate

extension DatePickerAdapter: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = datePicker.date.toString(format: properties.format)
        date = datePicker.date
        dateHandler?(datePicker.date)
    }
}
