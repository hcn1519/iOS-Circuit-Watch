//
//  AddCircuitVC.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 27..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

class AddCircuitVC: UITableViewController {

    let cellID = "formCell"
    var selectedIndexPath: IndexPath?
    
        var dataArray: [[String: String]] = []
        let titleKey = "title"
        let detailKey = "detail"
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationBar.tintColor = .white
    
            let itemOne = [titleKey : "Title1", detailKey : "Hello Detail1"] as [String : String]
            let itemTwo = [titleKey : "Title2", detailKey : "Hello Detail2"] as [String : String]
            let itemThree = [titleKey : "Title3", detailKey : "Hello Detail3"] as [String : String]
            let itemFour = [titleKey : "Title4", detailKey : "Hello Detail4"] as [String : String]
            let itemFive = [titleKey : "Title5", detailKey : "Hello Detail5"] as [String : String]
            let itemSix = [titleKey : "Title6", detailKey : "Hello Detail6"] as [String : String]
    
            dataArray.append(itemOne)
            dataArray.append(itemTwo)
            dataArray.append(itemThree)
            dataArray.append(itemFour)
            dataArray.append(itemFive)
            dataArray.append(itemSix)
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemData = dataArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? FormCell
        
        cell?.titleLabel.text = itemData[titleKey]! as String
        cell?.detailLabel.text = itemData[detailKey]! as String
        
        return cell!
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! FormCell).watchFrameChanges()
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! FormCell).ignoreFrameChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells as! [FormCell] {
            cell.ignoreFrameChanges()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return FormCell.expandedHeight
        } else {
            return FormCell.defaultheight
        }
    }
    
    
}
