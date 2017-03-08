//
//  NumberInputCell.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 27..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit



class NumberInputCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberField: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func didEndOnExit(_ sender: UITextField) {
        numberField.endEditing(true)
    }
}
