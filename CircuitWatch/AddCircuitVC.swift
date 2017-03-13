//
//  AddCircuitVC.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 27..
//  Copyright © 2017년 홍창남. All rights reserved.
//

// issue - 수정을 위해 설정해놓은 시간 고치려고 칸을 누르면 리셋되어 버림
import UIKit


var selectedMin: Int! = 1
var selectedSec: Int! = 30
var workoutTitle: String = ""
var workoutCount: Int = 0
var setCount: Int = 0


class AddCircuitVC: UITableViewController {

    let formCellID = "formCell"
    let wordCellID = "wordCell"
    let inputCellID = "inputCell"

    var selectedIndexPath: IndexPath?
    var dataArray: [[String: String]] = []
    
    let titleKey = "title"
    let minuteKey = "min"
    let secondkey = "sec"
    var isFirstLoad: Bool = true
    var pickerData = [[Int]?]()
    
    var updateTime = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationController?.navigationBar.isTranslucent = false
 
        let title = [titleKey: "Title of Training"]
        let itemOne = [titleKey : "Prepare Time"]
        let itemTwo = [titleKey : "Workout Time"]
        let itemThree = [titleKey : "How many Workout?"]
        let itemFour = [titleKey : "How many Set?"]
        let itemFive = [titleKey : "Workout BreakTime"]
        let itemSix = [titleKey : "Set BreakTime"]
        let itemSeven = [titleKey : "Wrapup Time"]
        let total = [titleKey : "Total Time"]
        
        dataArray.append(title)
        dataArray.append(itemOne)
        dataArray.append(itemTwo)
        dataArray.append(itemThree)
        dataArray.append(itemFour)
        dataArray.append(itemFive)
        dataArray.append(itemSix)
        dataArray.append(itemSeven)
        dataArray.append(total)
        
        
        pickerData.append(nil)
        pickerData.append([1,30])
        pickerData.append([1,30])
        pickerData.append(nil)
        pickerData.append(nil)
        pickerData.append([1,30])
        pickerData.append([1,30])
        pickerData.append([1,30])
        
        updateTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshTotalTime), userInfo: nil, repeats: true)
        updateTime.fire()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemData = dataArray[indexPath.row]
        var cellID = wordCellID
        
        if indexPath.row == 8 {
            cellID = wordCellID
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? WordCell {
                
                cell.selectionStyle = .none;
                cell.titleLabel.text = itemData[titleKey]
                cell.detailLabel.text = "03min 0sec"
                
                if let _ = tableView.lastIndexPath {
                    isFirstLoad = false
                }
                return cell
            }
            return UITableViewCell()
        } else if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4 {
            cellID = inputCellID
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? InputCell {
                
                cell.selectionStyle = .none;
                cell.textField.frame.size.width = 120
                cell.titleLabel.text = itemData[titleKey]
                
                if indexPath.row == 0 {
                    cell.textField.placeholder = "Title of Training"
                    cell.fieldType = textFieldCase.StringFieldTag
                } else if indexPath.row == 3 {
                    cell.textField.placeholder = "Count"
                    cell.fieldType = textFieldCase.NumberFieldTag
                } else {
                    cell.textField.placeholder = "Count"
                    cell.fieldType = textFieldCase.NumberFieldTag
                }
                
                let viewTapGestureRec = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
                viewTapGestureRec.cancelsTouchesInView = false
                self.tableView.addGestureRecognizer(viewTapGestureRec)
                
                return cell
            }
            return UITableViewCell()
            
        } else {
            cellID = formCellID
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? FormCell {
                cell.titleLabel.text = itemData[titleKey]
                
                let min = pickerData[indexPath.row]?[0]
                let sec = pickerData[indexPath.row]?[1]
                
                
                cell.detailLabel.text = makeTimeString(min: min!, sec: sec!)
                
                if isFirstLoad {
                    cell.detailLabel.text = makeTimeString(min: min!, sec: sec!)
                }
            
                return cell
            }
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row != 3 && indexPath.row != 4 && indexPath.row != 8 {
            let previousIndexPath = selectedIndexPath
            
            if indexPath == selectedIndexPath {
                selectedIndexPath = nil
            } else {
                selectedIndexPath = indexPath
            }
            
            var indexPaths: Array<IndexPath> = []
            if let previous = previousIndexPath {
                indexPaths += [previous]
            }
            if let current = selectedIndexPath {
                indexPaths += [current]
            }
            
            
            if indexPaths.count > 0 {
                tableView.reloadRows(at: indexPaths, with: .automatic)
            }
        }
//        print(Time.currentTime.totalTimeSec)
//        print(Time.currentTime.description)
//        refreshTotalTime()
    }
    
    // draw a cell for a particular row
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row != 3 && indexPath.row != 4 && indexPath.row != 8 {
            if let cell = (cell as? FormCell) {
                // observer
                cell.watchFrameChanges()

                // pickerView 바꾼 value 불러오기
                let min = pickerData[indexPath.row]?[0]
                let sec = pickerData[indexPath.row]?[1]
                
                cell.pickerView.selectRow(min!, inComponent: 0, animated: true)
                cell.pickerView.selectRow(sec!, inComponent: 1, animated: true)
                
//                print("drawing \(indexPath.row)")
//                print(pickerData)
//                print("===")
                
                // 펼쳐진 셀을 접을 때 실행
                // 다른 셀
                if selectedIndexPath != nil && selectedIndexPath != indexPath {
//                    print("from draw \(indexPath)")
                    let prevMin = pickerData[indexPath.row]?[0]
                    let prevSec = pickerData[indexPath.row]?[1]
//                    print("selected from draw \(selectedIndexPath)")
                    
                    if let prev = tableView.cellForRow(at: indexPath) as? FormCell {
                        prev.detailLabel.text = makeTimeString(min: prevMin!, sec: prevSec!)
                        pickerData[indexPath.row]?[0] = prevMin!
                        pickerData[indexPath.row]?[1] = prevSec!
                    }
                // 같은 셀
                }
//                else if selectedIndexPath == nil {
//                    let currentMin = cell.pickerView.selectedRow(inComponent: 0)
//                    let currentSec = cell.pickerView.selectedRow(inComponent: 1)
//                    
//                    pickerData[indexPath.row]?[0] = currentMin
//                    pickerData[indexPath.row]?[1] = currentSec
//                    
//                    if let sameCell = tableView.cellForRow(at: indexPath) as? FormCell {
//                        sameCell.detailLabel.text = makeTimeString(min: currentMin, sec: currentSec)
//                        print(sameCell.detailLabel.text)
//                    }
//                    
//                    print(pickerData)
//                }
                
                
//                print("=====")
//                print("selected \(selectedIndexPath?.row)")
//                print(previousIndexPath)
//                print("=====")
//                
//                print("-------------------------")
//                print("draw End")
            }
        }
        refreshTotalTime()
    }
    // specified cell was removed from the table
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row != 3 && indexPath.row != 4 && indexPath.row != 8 {
            
            if let cell = (cell as? FormCell) {
                cell.ignoreFrameChanges()
                
                // pickerView value 지정하기
                
                let min = cell.pickerView.selectedRow(inComponent: 0)
                let sec = cell.pickerView.selectedRow(inComponent: 1)

                pickerData[indexPath.row]?[0] = min
                pickerData[indexPath.row]?[1] = sec

//                print("removing \(indexPath.row)")
//                print(pickerData)
//                print("selected \(selectedIndexPath?.row)")
                
                if selectedIndexPath != nil && selectedIndexPath != indexPath {
//                    print("from did \(indexPath)")
                    let prevMin = pickerData[indexPath.row]?[0]
                    let prevSec = pickerData[indexPath.row]?[1]
//                    print("from did \(selectedIndexPath)")
                    
                    if let prev = tableView.cellForRow(at: indexPath) as? FormCell {
                        prev.detailLabel.text = makeTimeString(min: prevMin!, sec: prevSec!)
                        pickerData[indexPath.row]?[0] = prevMin!
                        pickerData[indexPath.row]?[1] = prevSec!
                    }
                    
                }
                else if selectedIndexPath == nil {
                    let currentMin = cell.pickerView.selectedRow(inComponent: 0)
                    let currentSec = cell.pickerView.selectedRow(inComponent: 1)
                    
                    pickerData[indexPath.row]?[0] = currentMin
                    pickerData[indexPath.row]?[1] = currentSec
                    
                    if let sameCell = tableView.cellForRow(at: indexPath) as? FormCell {
                        sameCell.detailLabel.text = makeTimeString(min: currentMin, sec: currentSec)
                    }
                }
            
                
                if indexPath.row == 1 {
                    Time.currentTime.prepareTimeMin = min
                    Time.currentTime.prepareTimeSec = sec
                } else if indexPath.row == 2 {
                    Time.currentTime.workoutTimeMin = min
                    Time.currentTime.workoutTimeSec = sec
                } else if indexPath.row == 5 {
                    Time.currentTime.workoutBreakTimeMin = min
                    Time.currentTime.workoutBreakTimeSec = sec
                } else if indexPath.row == 6 {
                    Time.currentTime.setBreakTimeMin = min
                    Time.currentTime.setBreakTimeSec = sec
                } else if indexPath.row == 7 {
                    Time.currentTime.wrapUpTimeMin = min
                    Time.currentTime.wrapUpTimeSec = sec
                }
                
            }
            
            print("enddisplay indexPath \(indexPath.row)")
        }
        refreshTotalTime()
    }
    
    func makeTimeString(min: Int, sec: Int) -> String {
        var minute = ""
        var second = ""
        
        if min < 10 {
            if min == 0 {
                minute = "0min"
            } else {
                minute = "0\(min)min"
            }
        } else {
            minute = "\(min)min"
        }
    
        if sec < 10 {
            if sec == 0 {
                second = " 0sec"
            } else {
                second = " 0\(sec)sec"
            }
        } else {
            second = " \(sec)sec"
        }
        return (minute + second)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells {
            if cell.isKind(of: FormCell.self) {
                (cell  as! FormCell).ignoreFrameChanges()
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 0 && indexPath.row != 3 && indexPath.row != 4 && indexPath.row != 8 {
            if indexPath == selectedIndexPath {
                return FormCell.expandedHeight
            } else {
                return FormCell.defaultheight
            }
        }
        return 44
    }
    
    // UserDefault 데이터 저장
    func saveToUserDefaults(dataObject: Time) {
        var newTime = [Time]()
        if let loadedData = UserDefaults().data(forKey: "encodedTimeData") {
            
            if let loadedTime = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as? [Time] {
                for time in loadedTime {
                    newTime.append(time)
                }
            }
        }
        newTime.append(dataObject)
        
        let encodedTimeData = NSKeyedArchiver.archivedData(withRootObject: newTime)
        UserDefaults().set(encodedTimeData, forKey: "encodedTimeData")
    }
    
    // view tap
    func handleViewTap(recognizer: UIGestureRecognizer) {
        self.tableView.endEditing(true)
//        print(Time.currentTime.description)
        refreshTotalTime()
    }
    
    // 전체시간 Label 업데이트
    func refreshTotalTime() {
        if let lastIndexPath = tableView.lastIndexPath {
            let lastCell = tableView.cellForRow(at: lastIndexPath) as? WordCell
            
//            
//            print("=== RefreshTotalTime Start ===")
//            print(Time.currentTime.description)
//            print("=== RefreshTotalTime End ===")
            let total = Time.currentTime.calulateTotalTime()
            
            
            lastCell?.timeStringSet(total.0, total.1)
        }
    }
    
    func alertHandle(title: String, message: String, style: UIAlertControllerStyle) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func addBtnPressed(_ sender: UIButton) {
//        refreshTotalTime()
        
        // error handle
        if workoutCount == 0 {
            alertHandle(title: "Count Value Error", message: "Invalid Workout Count", style: .alert)
        } else if setCount == 0 {
            alertHandle(title: "Count Value Error", message: "Invalid SetCount", style: .alert)
        }

//        print(Time.currentTime.description)
        saveToUserDefaults(dataObject: Time.currentTime)
        
        updateTime.invalidate()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension UITableView {
    
    var lastIndexPath: IndexPath? {
        
        let lastSectionIndex = numberOfSections - 1
        guard lastSectionIndex >= 0 else { return nil }
        
        let lastIndexInLastSection = numberOfRows(inSection: lastSectionIndex) - 1
        guard lastIndexInLastSection >= 0 else { return nil }
        
        return IndexPath(row: lastIndexInLastSection, section: lastSectionIndex)
    }
}
