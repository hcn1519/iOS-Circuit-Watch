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
            
            cell.trainingTitle.text = "\(dataArray.circuitTitle)"

            
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
    
    // 데이터 전송 segue 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let time = circuitData[indexPath.row]
        performSegue(withIdentifier: "goToCircuit", sender: time)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCircuit" {
            if let destination = segue.destination as? CircuitVC {
                if let item = sender as? Time {
                    destination.timeData = item
                }
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
        
        if tableView.isEditing {
            self.editButton.title = "Done".localized
        } else {
            self.editButton.title = "Edit".localized
        }
    }
    
    /*  테스트 데이터 생성용
    func generateTestData() {
        let temp1 = Time(circuitTitle: "첫 번째 트레이닝", prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 22, totalTimeSec: 0)
        let temp2 = Time(circuitTitle: "23분 트레이닝",prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 23, totalTimeSec: 0)
        let temp3 = Time(circuitTitle: "3 번째 트레이닝",prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 23, totalTimeSec: 0)
        
        circuitData.append(temp1)
        circuitData.append(temp2)
        circuitData.append(temp3)
    }
*/
}
