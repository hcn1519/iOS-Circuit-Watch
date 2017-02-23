//
//  TimeCell.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 22..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import Foundation

// date로 변환해야함

class TimeCell {
    private var _prepareTime: Double!
    private var _workoutTime: Double!
    private var _workoutCount: Int!
    private var _setCount: Int!
    private var _workoutBreakTime: Double!
    private var _setBreakTime: Double!
    private var _wrapUpTime: Double!
    private var _totalTime: Double!
    
    init(prepareTime: Double, workoutTime: Double, workoutCount: Int, setCount: Int, workoutBreakTime: Double, setBreakTime: Double, wrapUpTime: Double) {
        self._prepareTime = prepareTime
        self._workoutTime = workoutTime
        self._workoutCount = workoutCount
        self._setCount = setCount
        self._workoutBreakTime = workoutBreakTime
        self._setBreakTime = setBreakTime
        self._wrapUpTime = wrapUpTime
    }

    var prepareTime: Double {
        get {
            return _prepareTime
        } set {
            _prepareTime = newValue
        }
    }
    var workoutTime: Double {
        get {
            return _workoutTime
        } set {
            _workoutTime = newValue
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
    var workoutBreakTime: Double {
        get {
            return _workoutBreakTime
        } set {
            _workoutBreakTime = newValue
        }
    }
    var setBreakTime: Double {
        get {
            return _setBreakTime
        } set {
            _setBreakTime = newValue
        }
    }
    var wrapUpTime: Double {
        get {
            return _wrapUpTime
        } set {
            _wrapUpTime = newValue
        }
    }
    
    
}
