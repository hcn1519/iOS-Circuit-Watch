//
//  DataHelper.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 3. 19..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import Foundation

class DataHelper {
    // UserDefault 데이터 저장
    static func saveToUserDefaults(dataObject: Time, editTime: Time?, editIndexPath: IndexPath?) {
        
        var newTime = [Time]()
        if let loadedData = UserDefaults().data(forKey: "encodedTimeData") {
            
            if let loadedTime = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as? [Time] {
                for time in loadedTime {
                    newTime.append(time)
                }
            }
        }
        // edit 상태이면 수정
        if editTime == nil {
            newTime.append(dataObject)
        } else {
            if let indexPath = editIndexPath {
                newTime[indexPath.row] = dataObject
            }
        }
        let encodedTimeData = NSKeyedArchiver.archivedData(withRootObject: newTime)
        UserDefaults().set(encodedTimeData, forKey: "encodedTimeData")
    }
}
