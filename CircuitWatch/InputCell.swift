//
//  NumberInputCell.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 27..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

enum textFieldCase {
    case DefaultTag, StringFieldTag, NumberFieldTag
}

class InputCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
  
    private var _fieldType = textFieldCase.DefaultTag
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    var fieldType: textFieldCase {
        get { return _fieldType }
        set {
            if newValue == .NumberFieldTag {
                textField.keyboardType = .numberPad
            } else {
                textField.keyboardType = .default
            }
            _fieldType = newValue
        }
    }
    func textChanged() {
        switch self._fieldType {
        case .NumberFieldTag:
            if let text = self.textField.text {
                let value = Int(text)
                if titleLabel.text == "How many Workout?".localized {
                    if value != nil {
                        workoutCount = value!
                    }
                    Time.currentTime.workoutCount = workoutCount
                } else {
                    if value != nil {
                        setCount = value!
                    }
                    Time.currentTime.setCount = setCount
                }
            }
        case .StringFieldTag:
            if let text = self.textField.text {
                let value = text
                workoutTitle = value
                Time.currentTime.circuitTitle = workoutTitle
            }
            break
        case .DefaultTag:
            break
        }
    }

    @IBAction func didEndOnExit(_ sender: UITextField) {
        textField.endEditing(true)
    }
}
