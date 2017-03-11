//
//  FormCell.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 2. 24..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    // variable
    var isObserving = false
    let minutes = Array(0...59)
    
    // initialize pickerView delegate, dataSource
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        setUpViews()
    }
    
    // tableViewCell's height setup
    class var expandedHeight: CGFloat { get { return 200 } }
    class var defaultheight: CGFloat { get { return 44 } }
    
    func checkHeight() {
        pickerView.isHidden = (frame.height < FormCell.expandedHeight)
    }
    
    let minLabel: UILabel = {
        let label = UILabel()
        label.text = "min"
        label.font = UIFont(name: "Helvetica Neue", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let secLabel: UILabel = {
        let label = UILabel()
        label.text = "sec"
        label.font = UIFont(name: "Helvetica Neue", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews(){
        pickerView.addSubview(minLabel)
        pickerView.addSubview(secLabel)
        
        pickerView.selectRow(1, inComponent: 0, animated: true)
        pickerView.selectRow(30, inComponent: 1, animated: true)
        detailLabel.text = "01min 30sec"
        timeSetup = "01min 30sec"
        
        let marginTop = pickerView.frame.height / 3 + 3
        let marginLeft = pickerView.frame.width / 3 + 20
        
        minLabel.topAnchor.constraint(equalTo: pickerView.topAnchor, constant: marginTop).isActive = true
        secLabel.topAnchor.constraint(equalTo: pickerView.topAnchor, constant: marginTop + 0.5).isActive = true
        
        
        if UIDevice.current.isiPadPro12 {
            let padMargin = self.frame.width
            minLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: padMargin).isActive = true
            secLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: padMargin * 2).isActive = true
        } else if UIDevice.current.isiPad {
            let padMargin = self.frame.width / 2
            minLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: padMargin + 90).isActive = true
            secLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: padMargin * 2 + 160).isActive = true
        } else if UIDevice.current.isiPhonePlus {
            minLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: marginLeft + 5).isActive = true
            secLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: marginLeft * 2 + 5).isActive = true
        } else if UIDevice.current.isiPhoneSE {
            let seMargin = self.frame.width / 4
            minLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: seMargin + 15).isActive = true
            secLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: seMargin * 2 + 32).isActive = true
        } else {
            minLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: marginLeft).isActive = true
            secLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: marginLeft * 2 - 20).isActive = true
        }
        
    }
    
    // for pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minutes.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        var titleData = ""
        titleData = "\(minutes[row])"
        pickerLabel.text = titleData
        pickerLabel.textAlignment = .center
        pickerLabel.textColor = .white
        pickerLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var label = self.detailLabel.text
        
        let minIndex = label?.index((label?.startIndex)!, offsetBy: 5)
        var minute = label?.substring(to: minIndex!)
        
        let secIndex = label?.index((label?.startIndex)!, offsetBy: 5)
        var second = label?.substring(from: secIndex!)
        
        if component == 0 {
            if row < 10 {
                if row == 0 {
                    minute = "0min"
                } else {
                    minute = "0\(row)min"
                }
                
            } else {
                minute = "\(row)min"
            }
        } else {
            if row < 10 {
                if row == 0 {
                    second = " 0sec"
                } else {
                    second = " 0\(row)sec"
                }
                
            } else {
                second = " \(row)sec"
            }
        }
        label = minute! + second!
        self.detailLabel.text = label
//        print("from pick \(label!)")
        
        timeSetup = self.detailLabel.text
        
        let min = pickerView.selectedRow(inComponent: 0)
        let sec = pickerView.selectedRow(inComponent: 1)
        
        selectedMin = min
        selectedSec = sec
        
    }

    // set observer for expanding
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true;
        }
    }
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }

}


