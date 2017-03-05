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

class AddCircuitVC: UITableViewController {

    let formCellID = "formCell"
    let wordCellID = "wordCell"
    let numberInputCellID = "numberInputCell"

    var selectedIndexPath: IndexPath?
    
    var dataArray: [[String: String]] = []
    
    var isAlreadyPicked = Array(repeating: false, count: 8)
    
    let titleKey = "title"
    
    let minuteKey = "min"
    let secondkey = "sec"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
    
        let title = [titleKey: "Name"]
        let itemOne = [titleKey : "Prepare Time"]
        let itemTwo = [titleKey : "Workout Time"]
        
        let itemThree = [titleKey : "Workout Count"]
        let itemFour = [titleKey : "Set Count"]
        
        let itemFive = [titleKey : "Workout BreakTime"]
        let itemSix = [titleKey : "Set BreakTime"]
        let itemSeven = [titleKey : "Wrapup Time"]
        
        let total = [titleKey : "Total Time"]
        
    
//        dataArray.append(title)
        
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
            
            return cell!
        } else if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4 {
            cellID = numberInputCellID
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? NumberInputCell
            cell?.selectionStyle = .none;
            cell?.titleLabel.text = itemData[titleKey]
            
            if indexPath.row == 0 {
               cell?.numberField.frame.size.width = 150
               cell?.numberField.placeholder = "Title of the Training"
            }
            
            return cell!
        } else {
            cellID = formCellID
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? FormCell
            cell?.titleLabel.text = itemData[titleKey]
            
            // check indexPath is what I tapped
            // 안되는 기능 : 다시 눌렀을 때 숫자가 변경되어 버림
            if indexPath != selectedIndexPath {
                if let timeSetup = timeSetup {
                    cell?.detailLabel.text = timeSetup
                    
                    if selectedIndexPath != nil {
                        cell?.pickerView.selectRow(selectedMin, inComponent: 0, animated: true)
                        cell?.pickerView.selectRow(selectedSec, inComponent: 1, animated: true)
                    }
                    
                    print("from if \(timeSetup)")
                    
                }
            } else {
                print("from else timeSetup \(timeSetup)")
                
                if selectedIndexPath != nil && selectedIndexPath != indexPath {
                    cell?.pickerView.selectRow(selectedMin, inComponent: 0, animated: true)
                    cell?.pickerView.selectRow(selectedSec, inComponent: 1, animated: true)
                    cell?.detailLabel.text = timeSetup
                } else {
                    // initialize value to default one.
                    cell?.pickerView.selectRow(1, inComponent: 0, animated: true)
                    cell?.pickerView.selectRow(30, inComponent: 1, animated: true)
                    cell?.detailLabel.text = "01min 30sec"
                }
                
                
                
               
            }
            
            
            return cell!
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        
        let time = Time(circuitTitle: "", prepareTimeMin: 0, prepareTimeSec: 0, workoutTimeMin: 0, workoutTimeSec: 0, workoutCount: 0, setCount: 0, workoutBreakTimeMin: 0, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 0, wrapUpTimeMin: 0, wrapUpTimeSec: 0, totalTimeMin: 0, totalTimeSec: 0)
        
        let indexPath = self.tableView.indexPathsForVisibleRows

        
        var flagForFormCell = 1
        var flagForCountCell = 1
        for i in 0...tableView.numberOfSections-1 {
            for j in 0...tableView.numberOfRows(inSection: i)-1 {
                if let cell = tableView.cellForRow(at: (indexPath?[j])!) {
                    if cell.isKind(of: FormCell.self) {
                        // Input from PickerView
                        let minute: Int? = (cell  as! FormCell).pickerView.selectedRow(inComponent: 0)
                        let second: Int? = (cell  as! FormCell).pickerView.selectedRow(inComponent: 1)
                        
                        // pickerView에서 value값이 제대로 넘어오지 않음
                        print(minute!)
                        print(second!)
                        
                        if flagForFormCell == 1 {
                            if let min = minute {
                                if let sec = second {
                                    time.prepareTimeMin = min
                                    time.prepareTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.prepareTimeMin = min
                                    time.prepareTimeSec = 30
                                    flagForFormCell += 1
                                }
                            } else {
                                if let sec = second {
                                    time.prepareTimeMin = 1
                                    time.prepareTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.prepareTimeMin = 1
                                    time.prepareTimeSec = 30
                                    flagForFormCell += 1
                                }
                            }
                            
                        } else if flagForFormCell == 2{
                            if let min = minute {
                                if let sec = second {
                                    time.workoutTimeMin = min
                                    time.workoutTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.workoutTimeMin = min
                                    time.workoutTimeSec = 30
                                    flagForFormCell += 1
                                }
                            } else {
                                if let sec = second {
                                    time.workoutTimeMin = 1
                                    time.workoutTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.workoutTimeMin = 1
                                    time.workoutTimeSec = 30
                                    flagForFormCell += 1
                                }
                            }
                        } else if flagForFormCell == 3{
                            if let min = minute {
                                if let sec = second {
                                    time.workoutBreakTimeMin = min
                                    time.workoutBreakTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.workoutBreakTimeMin = min
                                    time.workoutBreakTimeSec = 30
                                    flagForFormCell += 1
                                }
                            } else {
                                if let sec = second {
                                    time.workoutBreakTimeMin = 1
                                    time.workoutBreakTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.workoutBreakTimeMin = 1
                                    time.workoutBreakTimeSec = 30
                                    flagForFormCell += 1
                                }
                            }
                        } else if flagForFormCell == 4{
                            if let min = minute {
                                if let sec = second {
                                    time.setBreakTimeMin = min
                                    time.setBreakTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.setBreakTimeMin = min
                                    time.setBreakTimeSec = 30
                                    flagForFormCell += 1
                                }
                            } else {
                                if let sec = second {
                                    time.setBreakTimeMin = 1
                                    time.setBreakTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.setBreakTimeMin = 1
                                    time.setBreakTimeSec = 30
                                    flagForFormCell += 1
                                }
                            }
                        } else if flagForFormCell == 5{
                            if let min = minute {
                                if let sec = second {
                                    time.wrapUpTimeMin = min
                                    time.wrapUpTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.wrapUpTimeMin = min
                                    time.wrapUpTimeSec = 30
                                    flagForFormCell += 1
                                }
                            } else {
                                if let sec = second {
                                    time.wrapUpTimeMin = 1
                                    time.wrapUpTimeSec = sec
                                    flagForFormCell += 1
                                } else {
                                    time.wrapUpTimeMin = 1
                                    time.wrapUpTimeSec = 30
                                    flagForFormCell += 1
                                }
                            }
                        }
                        
                    } else if cell.isKind(of: NumberInputCell.self) {
                        // Input from TextField(title)
                        if flagForCountCell == 1 {
                            let title = (cell  as! NumberInputCell).numberField.text!
                            if title != "" {
                                time.circuitTitle = title
                            } else {
                                time.circuitTitle = ""
                                
                            }
                            flagForCountCell += 1
                            continue
                        }
                        
                        // Input from TextField(count)
                        let count: Int? = Int((cell  as! NumberInputCell).numberField.text!)
                        
                        if let number = count {
                            if flagForCountCell == 2 {
                                time.workoutCount = number
                                flagForCountCell += 1
                            } else {
                                time.setCount = number
                            }
                        } else {
                            if flagForCountCell == 2 {
                                time.workoutCount = 0
                                flagForCountCell += 1
                            } else {
                                time.setCount = 0
                            }
                        }
                        
                    }
                }
            }
        }
        let total = calulateTotalTime(time)
        time.totalTimeMin = total.0
        time.totalTimeSec = total.1
        
        print(time.description)
        
    }
    func calulateTotalTime(_ time: Time) -> (Int, Int) {
        let prepareTime = (time.prepareTimeMin * 60) + time.prepareTimeSec
        let workoutTime = ((time.workoutTimeMin * 60) + time.workoutTimeSec) * time.workoutCount * time.setCount
        let workoutBreakTime = (time.workoutTimeMin * 60 + time.workoutTimeSec) * (time.workoutCount - 1)
        let setBreakTime = (time.setBreakTimeMin * 60 + time.setBreakTimeSec) * (time.setCount - 1) * time.workoutCount
        let wrapUpTime = (time.wrapUpTimeMin * 60 + time.wrapUpTimeSec)
        
        let totalTime = prepareTime + workoutTime + workoutBreakTime + setBreakTime + wrapUpTime
        
        let totalMinute = totalTime / 60
        let totalSecond = totalTime % 60
        
        return (totalMinute, totalSecond)
    }
}
