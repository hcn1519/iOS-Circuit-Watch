//
//  MainVC.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 23..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit



class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var circuitData = [Time]()
    var isEditingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        if !isAppAlreadyLaunchedOnce() {
            generateDefaultData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circuitData = getUserDefaultData()
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circuitData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "circuitCell", for: indexPath) as? CircuitCell {
            let dataArray = circuitData[indexPath.row]
            
            cell.trainingTitle.text = "\(dataArray.circuitTitle)".localized
            
            cell.trainingDetail.text = String(format: NSLocalizedString("%d Workouts - %d Sets", comment: ""), dataArray.workoutCount, dataArray.setCount)
            
            
            if dataArray.totalTimeMin < 10 {
                if dataArray.totalTimeSec < 10 {
                    cell.trainingTime.text = "0\(dataArray.totalTimeMin):0\(dataArray.totalTimeSec)"
                } else {
                    cell.trainingTime.text = "0\(dataArray.totalTimeMin):\(dataArray.totalTimeSec)"
                }
            } else {
                if dataArray.totalTimeSec < 10 {
                    cell.trainingTime.text = "\(dataArray.totalTimeMin):0\(dataArray.totalTimeSec)"
                } else {
                    cell.trainingTime.text = "\(dataArray.totalTimeMin):\(dataArray.totalTimeSec)"
                }
            }
            
            cell.selectionStyle = .none;
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.isiPad || UIDevice.current.isiPadPro12 {
            return 140
        } else {
            return 100
        }
    }
    
    // 데이터 전송 segue 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let time = circuitData[indexPath.row]
        if isEditingMode {
            performSegue(withIdentifier: "goToEditCircuit", sender: time)
            isEditingMode = false
            tableView.setEditing(false, animated: true)
            self.editButton.title = "Edit".localized
        } else {
            performSegue(withIdentifier: "goToCircuit", sender: time)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCircuit" {
            if let destination = segue.destination as? CircuitVC {
                if let item = sender as? Time {
                    destination.timeData = item
                }
            }
        } else if segue.identifier == "goToEditCircuit" {
            if isEditingMode {
                if let destination = segue.destination as? AddCircuitVC {
                    if let item = sender as? Time {
                        destination.editTime = item
                        if let indexPath = self.tableView.indexPathForSelectedRow {
                            destination.editIndexPath = indexPath
                        }
                        
                    }
                }
                Time.currentTime = (sender as? Time)!
            }
        } else if segue.identifier == "goToAddCircuit" {
            Time.currentTime = Time(circuitTitle: "", prepareTimeMin: 1, prepareTimeSec: 30, workoutTimeMin: 1, workoutTimeSec: 30, workoutCount: 0, setCount: 0, workoutBreakTimeMin: 1, workoutBreakTimeSec: 30, setBreakTimeMin: 1, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 30, totalTimeMin: 3, totalTimeSec: 0)
        }
    }
    
    // UserDefault 데이터 저장
    func getUserDefaultData() -> [Time] {
        var dataArray = [Time]()
        if let loadedData = UserDefaults().data(forKey: "encodedTimeData") {
            
            if let loadedTime = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as? [Time] {
                for time in loadedTime {
                    dataArray.append(time)
                }
                return dataArray
            }
        }
        return dataArray
    }
    
    // edit state에서 delete 클릭시 UserDefault 데이터 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            circuitData.remove(at: indexPath.row)
            
            let encodedTimeData = NSKeyedArchiver.archivedData(withRootObject: circuitData)
            UserDefaults().set(encodedTimeData, forKey: "encodedTimeData")
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)

        }
    }

    // IBAction
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        tableView.allowsSelectionDuringEditing = true
        
        if tableView.isEditing {
            self.editButton.title = "Done".localized
            self.isEditingMode = true
        } else {
            self.editButton.title = "Edit".localized
            self.isEditingMode = false
        }
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    func generateDefaultData() {
        let temp1 = Time(circuitTitle: "10 minutes Challange".localized, prepareTimeMin: 0, prepareTimeSec: 30, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 5, setCount: 1, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 0, wrapUpTimeSec: 30, totalTimeMin: 10, totalTimeSec: 0)
        let temp2 = Time(circuitTitle: "15 minutes a day Tabata".localized, prepareTimeMin: 0, prepareTimeSec: 15, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 5, setCount: 2, workoutBreakTimeMin: 0, workoutBreakTimeSec: 30, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 0, wrapUpTimeSec: 15, totalTimeMin: 15, totalTimeSec: 0)
        let temp3 = Time(circuitTitle: "20 minutes Circuit".localized, prepareTimeMin: 0, prepareTimeSec: 15, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 25, wrapUpTimeMin: 0, wrapUpTimeSec: 15, totalTimeMin: 20, totalTimeSec: 0)
        
        DataHelper.saveToUserDefaults(dataObject: temp1, editTime: nil, editIndexPath: nil)
        DataHelper.saveToUserDefaults(dataObject: temp2, editTime: nil, editIndexPath: nil)
        DataHelper.saveToUserDefaults(dataObject: temp3, editTime: nil, editIndexPath: nil)
    }
}
