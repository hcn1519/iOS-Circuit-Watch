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
    
    var circuitData = [Time]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        generateTestData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCircuit", sender: nil)
    }
    
    
    func generateTestData() {
        let temp1 = Time(circuitTitle: "첫 번째 트레이닝", prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 22, totalTimeSec: 0)
        let temp2 = Time(circuitTitle: "23분 트레이닝",prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 23, totalTimeSec: 0)
        let temp3 = Time(circuitTitle: "3 번째 트레이닝",prepareTimeMin: 1, prepareTimeSec: 0, workoutTimeMin: 1, workoutTimeSec: 0, workoutCount: 6, setCount: 2, workoutBreakTimeMin: 1, workoutBreakTimeSec: 0, setBreakTimeMin: 0, setBreakTimeSec: 30, wrapUpTimeMin: 1, wrapUpTimeSec: 0, totalTimeMin: 23, totalTimeSec: 0)
        
        circuitData.append(temp1)
        circuitData.append(temp2)
        circuitData.append(temp3)
    }
}
