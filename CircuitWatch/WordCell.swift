//
//  infoCell.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 27..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    // 시간 string 만들기
    func timeStringSet(_ min: Int, _ sec: Int) {
        
        var temp1 = ""
        var temp2 = ""
        
        if min < 10 {
            if min == 0 {
                temp1 = "0"
            } else {
                temp1 = "0\(min)"
            }
        } else {
            temp1 = "\(min)"
        }
        if sec < 10 {
            if sec == 0 {
                temp2 = "0"
            }
            temp2 = "0\(sec)"
        } else {
            temp2 = "\(sec)"
        }
        
        detailLabel.text = (temp1 + "min ".localized + temp2 + "sec".localized)
    }
}
