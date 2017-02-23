//
//  ViewController.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 22..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

class CircuitVC: UIViewController {

    @IBOutlet weak var circuitProgressView: ProgressBar!
    @IBOutlet weak var testSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func sliderMoved(_ sender: Any) {
        circuitProgressView.progress = CGFloat(testSlider.value)
    }

}

