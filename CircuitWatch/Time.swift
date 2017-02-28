//
//  TimeCell.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 22..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import Foundation

class Time: CustomStringConvertible {
    private var _circuitTitle: String!
    private var _prepareTimeMin: Int!
    private var _prepareTimeSec: Int!
    private var _workoutTimeMin: Int!
    private var _workoutTimeSec: Int!
    private var _workoutCount: Int!
    private var _setCount: Int!
    private var _workoutBreakTimeMin: Int!
    private var _workoutBreakTimeSec: Int!
    private var _setBreakTimeMin: Int!
    private var _setBreakTimeSec: Int!
    private var _wrapUpTimeMin: Int!
    private var _wrapUpTimeSec: Int!
    private var _totalTimeMin: Int!
    private var _totalTimeSec: Int!
    
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
            return _workoutTimeSec
        } set {
            _totalTimeSec = newValue
        }
    }
    
    var description: String {
        
        let string = "\(_circuitTitle): \(_prepareTimeMin) \(_prepareTimeSec) \(_workoutTimeMin) \(_workoutTimeSec) \(_workoutCount) \(_setCount) \(_workoutBreakTimeMin) \(_workoutBreakTimeSec) \(_setBreakTimeMin) \(_setBreakTimeSec) \(_wrapUpTimeMin) \(_wrapUpTimeSec) \(_totalTimeMin) \(_totalTimeSec)"
        return string
    }
}
