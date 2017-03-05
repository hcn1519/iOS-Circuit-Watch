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
    
    var timeSet: Time!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .white
        
    }
    func setUpTime() {
        
    }
    @IBAction func sliderMoved(_ sender: Any) {
        circuitProgressView.progress = CGFloat(testSlider.value)
    }

}

