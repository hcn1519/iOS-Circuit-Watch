//
//  NumberInputCell.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 27..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

class NumberInputCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let viewTapGestureRec = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        viewTapGestureRec.cancelsTouchesInView = false
        self.addGestureRecognizer(viewTapGestureRec)
    }
    func handleViewTap(recognizer: UIGestureRecognizer) {
        numberField.resignFirstResponder()
    }
}
