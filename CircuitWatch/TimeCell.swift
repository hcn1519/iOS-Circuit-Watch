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
    private var _prepareTime: Int!
    private var _workoutTime: Int!
    private var _workoutCount: Int!
    private var _setCount: Int!
    private var _workoutBreakTime: Int!
    private var _setBreakTime: Int!
    private var _wrapUpTime: Int!
    private var _totalTime: Int!
    
    init(prepareTime: Int, workoutTime: Int, workoutCount: Int, setCount: Int, workoutBreakTime: Int, setBreakTime: Int, wrapUpTime: Int) {
        self._prepareTime = prepareTime
        self._workoutTime = workoutTime
        self._workoutCount = workoutCount
        self._setCount = setCount
        self._workoutBreakTime = workoutBreakTime
        self._setBreakTime = setBreakTime
        self._wrapUpTime = wrapUpTime
    }

    var prepareTime: Int {
        get {
            return _prepareTime
        } set {
            _prepareTime = newValue
        }
    }
    var workoutTime: Int {
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
    var workoutBreakTime: Int {
        get {
            return _workoutBreakTime
        } set {
            _workoutBreakTime = newValue
        }
    }
    var setBreakTime: Int {
        get {
            return _setBreakTime
        } set {
            _setBreakTime = newValue
        }
    }
    var wrapUpTime: Int {
        get {
            return _wrapUpTime
        } set {
            _wrapUpTime = newValue
        }
    }
    
    
}
