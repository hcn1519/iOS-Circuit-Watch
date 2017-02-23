//
//  ProgressBar.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 22..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

class ProgressBar: UIView {
    private var _innerProgress: CGFloat = 0.0
    private var _totalTime: Double = 0
    
    var progress : CGFloat {
        set (newProgress) {
            if newProgress > 1.0 {
                _innerProgress = 1.0
            } else if newProgress < 0.0 {
                _innerProgress = 0
            } else {
                _innerProgress = newProgress
            }
            setNeedsDisplay()
        }
        get {
            return _innerProgress
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        CircuitProgress.drawCircuitProgress(frame: bounds, progress: progress)
    }
}
