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
    let breakSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "breakTime", ofType: "m4r"))!)
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
        titleLabel.text = timeData.circuitTitle
        
        timeSection = makeSection(timeData)
        minuteCounter = timeData.totalTimeMin
        secondCounter = timeData.totalTimeSec
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        timeSet.invalidate()
    }
    
    // 매 초 당 돌아가는 코드
    func runTimedCode() {
        let maxProgress: CGFloat = CGFloat(toSecond(min: timeData.totalTimeMin, sec: timeData.totalTimeSec))
        
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
    
    // 버튼 클릭 사운드
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
    
    // 시간 string 만들기
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
    
    // 어떤 섹션(prepareTime)에 있는지 체크 후 리턴
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
    
    
/*  테스트 데이터 생성용
    func generateTestData() {
        let temp1 = Time(circuitTitle: "첫 번째 트레이닝", prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 22, totalTimeSec: 0)
        timeData = temp1
    }
*/
    
    // 시간 섹션 구간 설정
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
    @IBAction func runningBtnPressed(_ sender: CircuitBtn) {
        playSound(isBtnPressed: true)

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
        playSound(isBtnPressed: true)
        
        // 시간 초기화
        timeSet.invalidate()
        currentProgress = 0
        circuitProgressView.progress = currentProgress
        minuteCounter = timeData.totalTimeMin
        secondCounter = timeData.totalTimeSec
        remainTime.text = timeStringSet(minuteCounter, secondCounter)
        progressDescriptionLabel.text = "Before Start"
        
        // 시작 버튼 초기화
        startAndPauseBtn.isSelected = false
        startAndPauseBtn.setTitle("시작", for: .selected)
        isInProgress = false
        
    }
    
}

