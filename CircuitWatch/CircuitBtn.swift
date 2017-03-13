//
//  circuitBtn.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 22..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

class CircuitBtn: RoundBtn {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                
                UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.backgroundColor = UIColor(red: 183/255, green: 28/255, blue: 28/255, alpha: 0.9)
                    self.tintColor = self.backgroundColor
                    self.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9), for: .selected)
                    self.setTitle("Pause", for: .selected)
                }, completion: nil)
                
            case false:
                
                UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.backgroundColor = UIColor(red: 1/255, green: 87/255, blue: 155/255, alpha: 0.9)
                    self.tintColor = self.backgroundColor
                    self.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9), for: .normal)
                    self.setTitle("Start", for: .normal)
                    
                }, completion: nil)
                
            }
        }
    }
    
    
}
