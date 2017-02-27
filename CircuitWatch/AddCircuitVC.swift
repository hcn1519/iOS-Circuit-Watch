//
//  AddCircuitVC.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 27..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

class AddCircuitVC: UITableViewController {

    let formCellID = "formCell"
    let wordCellID = "wordCell"
    let numberInputCellID = "numberInputCell"

    var selectedIndexPath: IndexPath?
    
    var dataArray: [[String: String]] = []
    let titleKey = "title"
    let detailKey = "detail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
    
//        let title = [titleKey : "시간 설정하기(Tap)", detailKey : ""] as [String : String]
        
        let itemOne = [titleKey : "준비 스트레칭", detailKey : "Hello Detail1"] as [String : String]
        let itemTwo = [titleKey : "운동시간", detailKey : "Hello Detail2"] as [String : String]
        
        let itemThree = [titleKey : "운동 수", detailKey : "Hello Detail3"] as [String : String]
        let itemFour = [titleKey : "세트 수", detailKey : "Hello Detail4"] as [String : String]
        
        let itemFive = [titleKey : "운동 쉬는시간", detailKey : "Hello Detail5"] as [String : String]
        let itemSix = [titleKey : "세트 쉬는시간", detailKey : "Hello Detail6"] as [String : String]
        let itemSeven = [titleKey : "마무리 스트레칭", detailKey : "Hello Detail7"] as [String : String]
        
        let total = [titleKey : "전체시간", detailKey : "Hello Detail7"] as [String : String]
        
    
//        dataArray.append(title)
        
        
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
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemData = dataArray[indexPath.row]
        var cellID = wordCellID
        
        if indexPath.row == 7 {
            cellID = wordCellID
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? WordCell
            cell?.selectionStyle = .none;
            return cell!
        } else if indexPath.row == 2 || indexPath.row == 3 {
            cellID = numberInputCellID
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? NumberInputCell
            cell?.selectionStyle = .none;
            
            return cell!
        } else {
            cellID = formCellID
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? FormCell
            cell?.titleLabel.text = itemData[titleKey]! as String
            
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
//            print("배열: \(indexPaths)")
//            print("current: \(selectedIndexPath?.row)")
//            print("previous: \(previousIndexPath?.row)")
//            
//            if previousIndexPath != nil {
//                if let cell = tableView.cellForRow(at: previousIndexPath!) as? FormCell {
//                    let min = cell.pickerView.selectedRow(inComponent: 0)
//                    let sec = cell.pickerView.selectedRow(inComponent: 1)
//                    
//                    print("\(min)min \(sec)sec")
//                    cell.detailLabel.text = "\(min)min \(sec)sec"
//                }
//            }
            
            
        }
        
    }
    
    // observer
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 2 && indexPath.row != 3 && indexPath.row != 7 {
            (cell as! FormCell).watchFrameChanges()
        }
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 2 && indexPath.row != 3 && indexPath.row != 7 {
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
        if indexPath.row != 2 && indexPath.row != 3 && indexPath.row != 7 {
            if indexPath == selectedIndexPath {
                return FormCell.expandedHeight
            } else {
                return FormCell.defaultheight
            }
        }
        return 44
    }
    
}
