//
//  RoundBtn.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 3. 8..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit


class RoundBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }
}
