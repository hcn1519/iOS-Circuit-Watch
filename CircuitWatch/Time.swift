//
//  TimeCell.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 22..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import Foundation

class Time: NSObject, NSCoding {
    
    static var currentTime = Time(circuitTitle: "", prepareTimeMin: 1, prepareTimeSec: 30, workoutTimeMin: 1, workoutTimeSec: 30, workoutCount: 0, setCount: 0, workoutBreakTimeMin: 1, workoutBreakTimeSec: 30, setBreakTimeMin: 1, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 30, totalTimeMin: 3, totalTimeSec: 0)
    
    fileprivate var _circuitTitle: String!
    fileprivate var _prepareTimeMin: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }
    fileprivate var _prepareTimeSec: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _workoutTimeMin: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _workoutTimeSec: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _workoutCount: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _setCount: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _workoutBreakTimeMin: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _workoutBreakTimeSec: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _setBreakTimeMin: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _setBreakTimeSec: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _wrapUpTimeMin: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _wrapUpTimeSec: Int! {
        didSet {
            let time = self.calulateTotalTime()
            self._totalTimeMin = time.0
            self._totalTimeSec = time.1
        }
    }

    fileprivate var _totalTimeMin: Int!
    fileprivate var _totalTimeSec: Int!
    
    init(circuitTitle: String, prepareTimeMin: Int, prepareTimeSec: Int, workoutTimeMin: Int, workoutTimeSec: Int, workoutCount: Int, setCount: Int, workoutBreakTimeMin: Int, workoutBreakTimeSec: Int, setBreakTimeMin: Int, setBreakTimeSec: Int, wrapUpTimeMin: Int, wrapUpTimeSec: Int, totalTimeMin: Int, totalTimeSec: Int) {
        self._circuitTitle = circuitTitle
        self._prepareTimeMin = prepareTimeMin
        self._prepareTimeSec = prepareTimeSec
        self._workoutTimeMin = workoutTimeMin
        self._workoutTimeSec = workoutTimeSec
        self._workoutCount = workoutCount
        self._setCount = setCount
        self._workoutBreakTimeMin = workoutBreakTimeMin
        self._workoutBreakTimeSec = workoutBreakTimeSec
        self._setBreakTimeMin = setBreakTimeMin
        self._setBreakTimeSec = setBreakTimeSec
        self._wrapUpTimeMin = wrapUpTimeMin
        self._wrapUpTimeSec = wrapUpTimeSec
        self._totalTimeMin = totalTimeMin
        self._totalTimeSec = totalTimeSec
    }
    
    var circuitTitle: String {
        get {
            return _circuitTitle
        } set {
            _circuitTitle = newValue
        }
    }
    
    var prepareTimeMin: Int {
        get {
            return _prepareTimeMin
        } set {
            _prepareTimeMin = newValue
        }
    }
    var prepareTimeSec: Int {
        get {
            return _prepareTimeSec
        } set {
            _prepareTimeSec = newValue
        }
    }
    var workoutTimeMin: Int {
        get {
            return _workoutTimeMin
        } set {
            _workoutTimeMin = newValue
        }
    }
    var workoutTimeSec: Int {
        get {
            return _workoutTimeSec
        } set {
            _workoutTimeSec = newValue
        }
    }
    
    var workoutCount: Int {
        get {
            return _workoutCount
        } set {
            _workoutCount = newValue
        }
    }
    var setCount: Int {
        get {
            return _setCount
        } set {
            _setCount = newValue
        }
    }
    
    var workoutBreakTimeMin: Int {
        get {
            return _workoutBreakTimeMin
        } set {
            _workoutBreakTimeMin = newValue
        }
    }
    
    var workoutBreakTimeSec: Int {
        get {
            return _workoutBreakTimeSec
        } set {
            _workoutBreakTimeSec = newValue
        }
    }
    
    var setBreakTimeMin: Int {
        get {
            return _setBreakTimeMin
        } set {
            _setBreakTimeMin = newValue
        }
    }
    var setBreakTimeSec: Int {
        get {
            return _setBreakTimeSec
        } set {
            _setBreakTimeSec = newValue
        }
    }
    var wrapUpTimeMin: Int {
        get {
            return _wrapUpTimeMin
        } set {
            _wrapUpTimeMin = newValue
        }
    }
    var wrapUpTimeSec: Int {
        get {
            return _wrapUpTimeSec
        } set {
            _wrapUpTimeSec = newValue
        }
    }
    var totalTimeMin: Int {
        get {
            return _totalTimeMin
        } set {
            _totalTimeMin = newValue
        }
    }
    var totalTimeSec: Int {
        get {
            return _totalTimeSec
        } set {
            _totalTimeSec = newValue
        }
    }

    // UserDefault용 encode
    required convenience init(coder aDecoder: NSCoder) {
         let circuitTitle = aDecoder.decodeObject(forKey: "circuitTitle") as! String
         let prepareTimeMin = aDecoder.decodeInteger(forKey: "prepareTimeMin") 
         let prepareTimeSec = aDecoder.decodeInteger(forKey: "prepareTimeSec")
         let workoutTimeMin = aDecoder.decodeInteger(forKey: "workoutTimeMin")
         let workoutTimeSec = aDecoder.decodeInteger(forKey: "workoutTimeSec")
         let workoutCount = aDecoder.decodeInteger(forKey: "workoutCount")
         let setCount = aDecoder.decodeInteger(forKey: "setCount")
         let workoutBreakTimeMin = aDecoder.decodeInteger(forKey: "workoutBreakTimeMin")
         let workoutBreakTimeSec = aDecoder.decodeInteger(forKey: "workoutBreakTimeSec")
         let setBreakTimeMin = aDecoder.decodeInteger(forKey: "setBreakTimeMin")
         let setBreakTimeSec = aDecoder.decodeInteger(forKey: "setBreakTimeSec")
         let wrapUpTimeMin = aDecoder.decodeInteger(forKey: "wrapUpTimeMin")
         let wrapUpTimeSec = aDecoder.decodeInteger(forKey: "wrapUpTimeSec")
         let totalTimeMin = aDecoder.decodeInteger(forKey: "totalTimeMin")
         let totalTimeSec = aDecoder.decodeInteger(forKey: "totalTimeSec")
        self.init(circuitTitle: circuitTitle, prepareTimeMin: prepareTimeMin, prepareTimeSec: prepareTimeSec, workoutTimeMin: workoutTimeMin, workoutTimeSec: workoutTimeSec, workoutCount: workoutCount, setCount: setCount, workoutBreakTimeMin: workoutBreakTimeMin, workoutBreakTimeSec: workoutBreakTimeSec, setBreakTimeMin: setBreakTimeMin, setBreakTimeSec: setBreakTimeSec, wrapUpTimeMin: wrapUpTimeMin, wrapUpTimeSec: wrapUpTimeSec, totalTimeMin: totalTimeMin, totalTimeSec: totalTimeSec)
    }
    func encode(with aCoder: NSCoder) {
        if let circuitTitle = _circuitTitle { aCoder.encode(circuitTitle, forKey: "circuitTitle") }
        if let prepareTimeMin = _prepareTimeMin { aCoder.encode(prepareTimeMin, forKey: "prepareTimeMin") }
        if let prepareTimeSec = _prepareTimeSec { aCoder.encode(prepareTimeSec, forKey: "prepareTimeSec") }
        if let workoutTimeMin = _workoutTimeMin { aCoder.encode(workoutTimeMin, forKey: "workoutTimeMin") }
        if let workoutTimeSec = _workoutTimeSec { aCoder.encode(workoutTimeSec, forKey: "workoutTimeSec") }
        if let workoutCount = _workoutCount { aCoder.encode(workoutCount, forKey: "workoutCount") }
        if let setCount = _setCount { aCoder.encode(setCount, forKey: "setCount") }
        if let workoutBreakTimeMin = _workoutBreakTimeMin { aCoder.encode(workoutBreakTimeMin, forKey: "workoutBreakTimeMin") }
        if let workoutBreakTimeSec = _workoutBreakTimeSec { aCoder.encode(workoutBreakTimeSec, forKey: "workoutBreakTimeSec") }
        if let setBreakTimeMin = _setBreakTimeMin { aCoder.encode(setBreakTimeMin, forKey: "setBreakTimeMin") }
        if let setBreakTimeSec = _setBreakTimeSec { aCoder.encode(setBreakTimeSec, forKey: "setBreakTimeSec") }
        if let wrapUpTimeMin = _wrapUpTimeMin { aCoder.encode(wrapUpTimeMin, forKey: "wrapUpTimeMin") }
        if let wrapUpTimeSec = _wrapUpTimeSec { aCoder.encode(wrapUpTimeSec, forKey: "wrapUpTimeSec") }
        if let totalTimeMin = _totalTimeMin { aCoder.encode(totalTimeMin, forKey: "totalTimeMin") }
        if let totalTimeSec = _totalTimeSec { aCoder.encode(totalTimeSec, forKey: "totalTimeSec") }
    }

    // 전체시간 계산
    func calulateTotalTime() -> (Int, Int) {
        let prepareTime = toSecond(self.prepareTimeMin, self.prepareTimeSec)
        let workoutTime = toSecond(self.workoutTimeMin, self.workoutTimeSec) * self.workoutCount * self.setCount
        
        var workoutBreakTime = 0
        if self.workoutCount != 0 {
            workoutBreakTime = toSecond(self.workoutBreakTimeMin, self.workoutBreakTimeSec) * (self.workoutCount - 1)
        }
        
        var setBreakTime = 0
        if self.setCount != 0 {
            setBreakTime = toSecond(self.setBreakTimeMin, self.setBreakTimeSec) * (self.setCount - 1) * self.workoutCount
        }
        
        let wrapUpTime = toSecond(self.wrapUpTimeMin, self.wrapUpTimeSec)
        let totalTime = prepareTime + workoutTime + workoutBreakTime + setBreakTime + wrapUpTime
        
        
        let totalMinute = totalTime / 60
        let totalSecond = totalTime % 60

//        print(totalTime)
//        print(totalMinute)
//        print(totalSecond)
        
        return (totalMinute, totalSecond)
    }

    private func toSecond(_ min: Int, _ sec: Int) -> Int {
        return (min * 60 + sec)
    }
    
}

extension Time {
    override var description: String {
        let string = "\(_circuitTitle) //\(_prepareTimeMin) \(_prepareTimeSec) //\(_workoutTimeMin) \(_workoutTimeSec) //\(_workoutCount) \(_setCount) //\(_workoutBreakTimeMin) \(_workoutBreakTimeSec) //\(_setBreakTimeMin) \(_setBreakTimeSec) //\(_wrapUpTimeMin) \(_wrapUpTimeSec) // \(_totalTimeMin) \(_totalTimeSec)"
        return string
    }
}
