//
//  ViewController.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 22..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit
import AVFoundation

var timeSet = Timer()
var timeData = Time(circuitTitle: "첫 번째 트레이닝", prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 22, totalTimeSec: 0)

class CircuitVC: UIViewController {

    @IBOutlet weak var circuitProgressView: ProgressBar!
    @IBOutlet weak var remainTime: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressDescriptionLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    let pauseSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "pause", ofType: "m4r"))!)
    let breakSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "breakTime", ofType: "m4r"))!)
    
    var minuteCounter = timeData.totalTimeMin
    var secondCounter = timeData.totalTimeSec
    var progress: CGFloat!
    var currentProgress: CGFloat = 0
    let maxProgress: CGFloat = CGFloat(timeData.totalTimeMin * 60 + timeData.totalTimeSec)
    
    var timeSection = [Int: String]()
    
    var subTitle: [String: String] = ["section1": "Prepare Time", "section2": "Workout Time", "section3": "Workout BreakTime", "section4": "Set BreakTime", "section5": "Wrapup Time"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
//        generateTestData()
        remainTime.text = timeStringSet(timeData.totalTimeMin, timeData.totalTimeSec)
        titleLabel.text = timeData.circuitTitle
        
        timeSection = makeSection(timeData)
        
    }

    func runTimedCode() {
        progress = CGFloat(currentProgress / maxProgress)
        currentProgress += 1
        circuitProgressView.progress = progress
        
        if secondCounter == 0 {
            secondCounter = 60
        }
        if secondCounter == 60 {
            minuteCounter -= 1
        }
        secondCounter -= 1
        remainTime.text = timeStringSet(minuteCounter, secondCounter)
        
        progressDescriptionLabel.text = checkSection(timeData, currentProgress)
    }
    
    func playSound(isBtnPressed: Bool) {
        if isBtnPressed {
            do {
                try btnSound = AVAudioPlayer(contentsOf: pauseSoundURL)
                btnSound.prepareToPlay()
            } catch let err as NSError {
                print(err.debugDescription)
            }
        } else {
            do {
                try btnSound = AVAudioPlayer(contentsOf: breakSoundURL)
                btnSound.prepareToPlay()
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        
        
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
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
    
    func checkSection(_ data: Time, _ currentTime: CGFloat) -> String {
        let sortedTimeSection = timeSection.sorted(by: { $0.0 > $1.0 })
        
        let time = toSecond(min: data.totalTimeMin, sec: data.totalTimeSec)
        let currentTime = CGFloat(time) - currentTime
        var currentSection = ""
        var maximum = false
        var minimum = false
        
        for (key, section) in sortedTimeSection {
            if currentTime < CGFloat(key) {
                maximum = true
            }
            if currentTime > CGFloat(key) {
                minimum = true
                currentSection = section
            }
            if currentTime == CGFloat(key) {
                playSound(isBtnPressed: false)
            }
            if minimum && maximum {
                return currentSection
            }
        }
        
        return currentSection
    }
    
    
    
//    func generateTestData() {
//        let temp1 = Time(circuitTitle: "첫 번째 트레이닝", prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 22, totalTimeSec: 0)
//        timeData = temp1
//    }
    
    
    // 시작 때 하나를 만들고 그 섹션에 맞춰서 출력하기
    func makeSection(_ data: Time) -> [Int: String] {
        var allTime = toSecond(min: data.totalTimeMin, sec: data.totalTimeSec)
        
        let prepareEnd = toSecond(min: data.prepareTimeMin, sec: data.prepareTimeSec)
        
        let workoutTimeTotal = toSecond(min: data.workoutTimeMin, sec: data.workoutTimeSec)
        let setBreakTotal = toSecond(min: data.setBreakTimeMin, sec: data.setBreakTimeSec)
        let workoutBreakTotal = toSecond(min: data.workoutBreakTimeMin, sec: data.workoutBreakTimeSec)
        let wrapupTotal = toSecond(min: data.wrapUpTimeMin, sec: data.wrapUpTimeSec)
        
        // 준비시간 설정
        timeSection.updateValue(subTitle["section1"]!, forKey: allTime)
        allTime -= prepareEnd
        timeSection.updateValue(subTitle["section1"]!, forKey: allTime)
        
        // 운동 루틴시간 설정
        for i in 1...data.workoutCount {
            for k in 1...data.setCount {
                allTime -= workoutTimeTotal
                timeSection.updateValue(subTitle["section2"]!, forKey: allTime)
                if k != data.setCount {
                    allTime -= setBreakTotal
                    timeSection.updateValue(subTitle["section4"]!, forKey: allTime)
                }
            }
            if i != data.workoutCount {
                allTime -= workoutBreakTotal
                timeSection.updateValue(subTitle["section3"]!, forKey: allTime)
            }
        }
        
        // 마무리시간 설정
        allTime -= wrapupTotal
        timeSection.updateValue(subTitle["section5"]!, forKey: allTime)
        return timeSection
    }
    
    func toSecond(min: Int, sec: Int) -> Int {
        return (min * 60 + sec)
    }
    
    // IBAction
    @IBAction func startBtnPressed(_ sender: UIButton) {
        playSound(isBtnPressed: true)
        timeSet = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    @IBAction func pauseBtnPressed(_ sender: UIButton) {
        playSound(isBtnPressed: true)
        timeSet.invalidate()
    }

    
//    순서
//    준비시간 -> 운동 개수 * (세트 개수 * (운동시간 -> 마지막 운동시간 후는 제외(세트 쉬는 시간)) -> 운동 쉬는 시간) -> 마무리시간
    
}
