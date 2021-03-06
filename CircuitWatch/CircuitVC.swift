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


class CircuitVC: UIViewController {

    // outlet
    @IBOutlet weak var circuitProgressView: ProgressBar!
    @IBOutlet weak var remainTime: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressDescriptionLabel: UILabel!
    @IBOutlet weak var startAndPauseBtn: CircuitBtn!
    @IBOutlet weak var resetBtn: RoundBtn!
    
    
    // variable
    var btnSound: AVAudioPlayer!
    let pauseSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "pause", ofType: "m4r"))!)
    let breakSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "breakSound", ofType: "mp3"))!)
    let tickSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "tickingSound", ofType: "mp3"))!)
    
    var progress: CGFloat!
    var currentProgress: CGFloat = 0
    var timeSection = [Int: String]()
    
    var subTitle: [String: String] = ["section1": "Prepare Time", "section2": "Workout Time", "section3": "Workout BreakTime", "section4": "Set BreakTime", "section5": "Wrapup Time"]
    var timeData: Time!
    var minuteCounter = -1
    var secondCounter = -1

    var isInProgress: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        
        remainTime.text = timeStringSet(timeData.totalTimeMin, timeData.totalTimeSec)
        titleLabel.text = timeData.circuitTitle.localized
        
        timeSection = makeSection(timeData)
        timeSection = insertTick(section: timeSection)
        minuteCounter = timeData.totalTimeMin
        secondCounter = timeData.totalTimeSec
 
    }

    override func viewDidDisappear(_ animated: Bool) {
        timeSet.invalidate()
    }
    
    // 매 초 당 돌아가는 코드
    func runTimedCode() {
        let maxProgress: CGFloat = CGFloat(toSecond(timeData.totalTimeMin, timeData.totalTimeSec))
        
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
    
        if minuteCounter == 0 && secondCounter == 0 {
            alertHandle(title: "Workout Finish".localized, message: "Great job, You are done!".localized, style: .alert)
            remainTime.text = "00:00"
            circuitProgressView.progress = CGFloat(1)
            timeSet.invalidate()
            
        }
        remainTime.text = timeStringSet(minuteCounter, secondCounter)
        progressDescriptionLabel.text = checkSection(timeData, currentProgress)
        
    }
    func fetch(_ completion: () -> Void) {
        completion()
    }
    // 버튼 클릭 사운드
    func playSound(isBtnPressed: Bool, tickTime: Bool) {
        if isBtnPressed {
            do {
                try btnSound = AVAudioPlayer(contentsOf: pauseSoundURL)
                btnSound.prepareToPlay()
            } catch let err as NSError {
                print(err.debugDescription)
            }
        } else if tickTime {
            do {
                try btnSound = AVAudioPlayer(contentsOf: tickSoundURL)
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
    
    // 시간 string 만들기
    func timeStringSet(_ min: Int, _ sec: Int) -> String {
        
        var temp1 = ""
        var temp2 = ""
        
        if min < 10 {
            if min == 0 {
                temp1 = "00"
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
    
    // 어떤 섹션(prepareTime)에 있는지 체크 후 리턴
    func checkSection(_ data: Time, _ currentTime: CGFloat) -> String {
        let sortedTimeSection = timeSection.sorted(by: { $0.0 > $1.0 })
            
        print(sortedTimeSection)
        
        let time = toSecond(data.totalTimeMin, data.totalTimeSec)
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
            }
            if currentTime == CGFloat(key) {
                if section == "tick" {
                    playSound(isBtnPressed: false, tickTime: true)
                } else {
                    playSound(isBtnPressed: false, tickTime: false)
                }
            }
            if minimum && maximum {
                if section == "tick" {
                    continue
                }
                currentSection = section
                return currentSection.localized
            }
        }
        return currentSection.localized
    }
    
    // 시간 섹션 구간 설정
    func makeSection(_ data: Time) -> [Int: String] {
        var allTime = toSecond(data.totalTimeMin, data.totalTimeSec) // 70
        
        let prepareEnd = toSecond(data.prepareTimeMin, data.prepareTimeSec)
        let workoutTimeTotal = toSecond(data.workoutTimeMin, data.workoutTimeSec)
        let setBreakTotal = toSecond(data.setBreakTimeMin, data.setBreakTimeSec)
        let workoutBreakTotal = toSecond(data.workoutBreakTimeMin, data.workoutBreakTimeSec)
        let wrapupTotal = toSecond(data.wrapUpTimeMin, data.wrapUpTimeSec)
        
        
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
    
    // tick 소리 넣기
    // issue: 5초 이하의 구간에 대해서는 오류 발생
    func insertTick(section: [Int: String]) -> [Int: String] {
        var section = section

        var temp: Int!
        for (key, value) in section {
            if value == subTitle["section1"] {
                if temp == nil {
                    temp = key
                } else {
                    if temp - key > 0 {
                        section.updateValue("tick", forKey: key+5)
                    }
                }
            } else if value != subTitle["section5"] {
                if temp != nil {
                    if temp - key > 0 {
                        section.updateValue("tick", forKey: key+5)
                    }
                }
            }
        }
        return section
    }
    
    func toSecond(_ min: Int, _ sec: Int) -> Int {
        return (min * 60 + sec)
    }
    
    func alertHandle(title: String, message: String, style: UIAlertControllerStyle) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // IBAction
    @IBAction func runningBtnPressed(_ sender: CircuitBtn) {
        playSound(isBtnPressed: true, tickTime: false)

        if isInProgress {
            sender.isSelected = false
            isInProgress = false
            timeSet.invalidate()
        } else {
            sender.isSelected = true
            isInProgress = true
            timeSet = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        }
    }
  
    @IBAction func resetBtnPressed(_ sender: Any) {
        playSound(isBtnPressed: true, tickTime: false)
        
        // 시간 초기화
        timeSet.invalidate()
        currentProgress = 0
        circuitProgressView.progress = currentProgress
        minuteCounter = timeData.totalTimeMin
        secondCounter = timeData.totalTimeSec
        remainTime.text = timeStringSet(minuteCounter, secondCounter)
        progressDescriptionLabel.text = "Before Start".localized
        
        // 시작 버튼 초기화
        startAndPauseBtn.isSelected = false
        startAndPauseBtn.setTitle("Start".localized, for: .selected)
        isInProgress = false
        
    }
    
}

