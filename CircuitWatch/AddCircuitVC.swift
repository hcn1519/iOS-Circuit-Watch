//
//  AddCircuitVC.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 27..
//  Copyright © 2017년 홍창남. All rights reserved.
//

// issue - 텍스트필드 눌렀을 때, 키보드가 사라지지 않음.
// issue - 수정을 위해 설정해놓은 시간 고치려고 칸을 누르면 리셋되어 버림
import UIKit

var timeSetup: String!
var selectedMin: Int! = 1
var selectedSec: Int! = 30
var workoutTitle: String = ""
var workoutCount: Int = 0
var setCount: Int = 0
var currentTime = Time(circuitTitle: "", prepareTimeMin: 1, prepareTimeSec: 30, workoutTimeMin: 1, workoutTimeSec: 30, workoutCount: 0, setCount: 0, workoutBreakTimeMin: 1, workoutBreakTimeSec: 30, setBreakTimeMin: 1, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 30, totalTimeMin: 3, totalTimeSec: 0)

class AddCircuitVC: UITableViewController {

    let formCellID = "formCell"
    let wordCellID = "wordCell"
    let inputCellID = "inputCell"

    var selectedIndexPath: IndexPath?
    var dataArray: [[String: String]] = []
    
    let titleKey = "title"
    let minuteKey = "min"
    let secondkey = "sec"
    
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? WordCell
            cell?.selectionStyle = .none;
            cell?.titleLabel.text = itemData[titleKey]
            cell?.detailLabel.text = "03min 0sec"
            
            return cell!
        } else if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4 {
            cellID = inputCellID
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? InputCell
            cell?.selectionStyle = .none;
            cell?.textField.frame.size.width = 120
            cell?.titleLabel.text = itemData[titleKey]
            
            if indexPath.row == 0 {
                cell?.textField.placeholder = "Title of Training"
                cell?.fieldType = textFieldCase.StringFieldTag
//                currentTime.detectTextFieldData(indexPath: indexPath, value: workoutTitle)
            } else if indexPath.row == 3 {
                cell?.textField.placeholder = "Count"
                cell?.fieldType = textFieldCase.NumberFieldTag
//                currentTime.detectTextFieldData(indexPath: indexPath, value: "\(workoutCount)")
            } else {
                cell?.textField.placeholder = "Count"
                cell?.fieldType = textFieldCase.NumberFieldTag
//                currentTime.detectTextFieldData(indexPath: indexPath, value: "\(setCount)")
            }
            
            let viewTapGestureRec = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
            viewTapGestureRec.cancelsTouchesInView = false
            self.tableView.addGestureRecognizer(viewTapGestureRec)
            
            return cell!
        } else {
            cellID = formCellID
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? FormCell
            cell?.titleLabel.text = itemData[titleKey]
            
            // 안되는 기능 : 다시 눌렀을 때 숫자가 변경되어 버림
            // 값 초기화 로직
            if indexPath != selectedIndexPath {
                if let timeSetup = timeSetup {
                    cell?.detailLabel.text = timeSetup
                    
                    if selectedIndexPath != nil {
                        cell?.pickerView.selectRow(selectedMin, inComponent: 0, animated: true)
                        cell?.pickerView.selectRow(selectedSec, inComponent: 1, animated: true)
                        currentTime.detectTimeData(indexPath: indexPath, min: selectedMin, sec: selectedSec)
                    }
                    
                    print("from if \(timeSetup)")
                }
            } else {
                print("from else timeSetup \(timeSetup)")
                
                if selectedIndexPath != nil && selectedIndexPath != indexPath {
                    cell?.pickerView.selectRow(selectedMin, inComponent: 0, animated: true)
                    cell?.pickerView.selectRow(selectedSec, inComponent: 1, animated: true)
                    cell?.detailLabel.text = timeSetup
                    currentTime.detectTimeData(indexPath: indexPath, min: selectedMin, sec: selectedSec)
                } else {
                    // initialize value to default one.
                    cell?.pickerView.selectRow(1, inComponent: 0, animated: true)
                    cell?.pickerView.selectRow(30, inComponent: 1, animated: true)
                    cell?.detailLabel.text = "01min 30sec"
                    currentTime.detectTimeData(indexPath: indexPath, min: 1, sec: 30)
                }
            }
            
            return cell!
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
                tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
            }
        }
        refreshTotalTime()
    }
    
    // observer
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row != 3 && indexPath.row != 4 && indexPath.row != 8 {
            (cell as! FormCell).watchFrameChanges()
        }
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row != 3 && indexPath.row != 4 && indexPath.row != 8 {
            (cell as! FormCell).ignoreFrameChanges()
        }
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
    
    func handleViewTap(recognizer: UIGestureRecognizer) {
        self.tableView.endEditing(true)
        print(currentTime.description)
        
        refreshTotalTime()
        
    }
    
    func refreshTotalTime() {
        if let lastIndexPath = tableView.lastIndexPath {
            let lastCell = tableView.cellForRow(at: lastIndexPath) as? WordCell
            
            lastCell?.timeStringSet(currentTime.totalTimeMin, currentTime.totalTimeSec)
        }
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        refreshTotalTime()
//        
//        let time = Time(circuitTitle: "", prepareTimeMin: 0, prepareTimeSec: 0, workoutTimeMin: 0, workoutTimeSec: 0, workoutCount: 0, setCount: 0, workoutBreakTimeMin: 0, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 0, wrapUpTimeMin: 0, wrapUpTimeSec: 0, totalTimeMin: 0, totalTimeSec: 0)
//        
//        let indexPath = self.tableView.indexPathsForVisibleRows
//
//        
//        var flagForFormCell = 1
//        var flagForCountCell = 1
//        for i in 0...tableView.numberOfSections-1 {
//            for j in 0...tableView.numberOfRows(inSection: i)-1 {
//                if let cell = tableView.cellForRow(at: (indexPath?[j])!) {
//                    if cell.isKind(of: FormCell.self) {
//                        // Input from PickerView
//                        let minute: Int? = (cell  as! FormCell).pickerView.selectedRow(inComponent: 0)
//                        let second: Int? = (cell  as! FormCell).pickerView.selectedRow(inComponent: 1)
//                        
//                        if flagForFormCell == 1 {
//                            if let min = minute {
//                                if let sec = second {
//                                    time.prepareTimeMin = min
//                                    time.prepareTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.prepareTimeMin = min
//                                    time.prepareTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            } else {
//                                if let sec = second {
//                                    time.prepareTimeMin = 1
//                                    time.prepareTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.prepareTimeMin = 1
//                                    time.prepareTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            }
//                            
//                        } else if flagForFormCell == 2{
//                            if let min = minute {
//                                if let sec = second {
//                                    time.workoutTimeMin = min
//                                    time.workoutTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.workoutTimeMin = min
//                                    time.workoutTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            } else {
//                                if let sec = second {
//                                    time.workoutTimeMin = 1
//                                    time.workoutTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.workoutTimeMin = 1
//                                    time.workoutTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            }
//                        } else if flagForFormCell == 3{
//                            if let min = minute {
//                                if let sec = second {
//                                    time.workoutBreakTimeMin = min
//                                    time.workoutBreakTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.workoutBreakTimeMin = min
//                                    time.workoutBreakTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            } else {
//                                if let sec = second {
//                                    time.workoutBreakTimeMin = 1
//                                    time.workoutBreakTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.workoutBreakTimeMin = 1
//                                    time.workoutBreakTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            }
//                        } else if flagForFormCell == 4{
//                            if let min = minute {
//                                if let sec = second {
//                                    time.setBreakTimeMin = min
//                                    time.setBreakTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.setBreakTimeMin = min
//                                    time.setBreakTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            } else {
//                                if let sec = second {
//                                    time.setBreakTimeMin = 1
//                                    time.setBreakTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.setBreakTimeMin = 1
//                                    time.setBreakTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            }
//                        } else if flagForFormCell == 5{
//                            if let min = minute {
//                                if let sec = second {
//                                    time.wrapUpTimeMin = min
//                                    time.wrapUpTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.wrapUpTimeMin = min
//                                    time.wrapUpTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            } else {
//                                if let sec = second {
//                                    time.wrapUpTimeMin = 1
//                                    time.wrapUpTimeSec = sec
//                                    flagForFormCell += 1
//                                } else {
//                                    time.wrapUpTimeMin = 1
//                                    time.wrapUpTimeSec = 30
//                                    flagForFormCell += 1
//                                }
//                            }
//                        }
//                        
//                    } else if cell.isKind(of: InputCell.self) {
//                        // Input from TextField(title)
//                        if flagForCountCell == 1 {
//                            let title = (cell  as! InputCell).textField.text!
//                            if title != "" {
//                                time.circuitTitle = title
//                            } else {
//                                time.circuitTitle = ""
//                                
//                            }
//                            flagForCountCell += 1
//                            continue
//                        }
//                        
//                        // Input from TextField(count)
//                        let count: Int? = Int((cell  as! InputCell).textField.text!)
//                        
//                        if let number = count {
//                            if flagForCountCell == 2 {
//                                time.workoutCount = number
//                                flagForCountCell += 1
//                            } else {
//                                time.setCount = number
//                            }
//                        } else {
//                            if flagForCountCell == 2 {
//                                time.workoutCount = 0
//                                flagForCountCell += 1
//                            } else {
//                                time.setCount = 0
//                            }
//                        }
//                        
//                    }
//                }
//            }
//        }
//        let total = time.calulateTotalTime()
//        time.totalTimeMin = total.0
//        time.totalTimeSec = total.1
        
        saveToUserDefaults(dataObject: currentTime)
        
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
