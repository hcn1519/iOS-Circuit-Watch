//
//  ViewController.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 22..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit
import AVFoundation

class CircuitVC: UIViewController {

    @IBOutlet weak var circuitProgressView: ProgressBar!
    @IBOutlet weak var testSlider: UISlider!
    @IBOutlet weak var remainTime: UILabel!
    
    var btnSound: AVAudioPlayer!
    let soundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "pause", ofType: "m4r"))!)
    
    var timeSet = Timer()
    var timeData: Time!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .white

        generateTestData()
        remainTime.text = timeStringSet(timeData.totalTimeMin, timeData.totalTimeSec)
        
        timeSet = Timer.scheduledTimer(timeInterval: Double(timeData.prepareTimeMin * 60 + timeData.prepareTimeSec), target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func runTimedCode() {
        
    }
    
    func timeStringSet(_ min: Int, _ sec: Int) -> String {
        
        var temp1 = ""
        var temp2 = ""
        
        if min < 10 {
            if min == 0 {
                temp1 = ""
            } else {
                temp1 = "0\(min)"
            }
            
        } else {
            temp1 = "\(min)"
        }
        if sec < 10 {
            if sec == 0 {
                temp2 = "\(sec)"
            }
            temp2 = "0\(sec)"
        } else {
            temp2 = "\(sec)"
        }
        
        return (temp1 + ":" + temp2)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func generateTestData() {
        let temp1 = Time(circuitTitle: "첫 번째 트레이닝", prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 22, totalTimeSec: 0)
        
        timeData = temp1
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        circuitProgressView.progress = CGFloat(testSlider.value)
    }
    @IBAction func startBtnPressed(_ sender: UIButton) {
        playSound()
    }
    @IBAction func pauseBtnPressed(_ sender: UIButton) {
        playSound()
    }

}

