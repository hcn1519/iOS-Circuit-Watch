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
        label.text = "분"
        label.font = UIFont(name: "Helvetica Neue", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let secLabel: UILabel = {
        let label = UILabel()
        label.text = "초"
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
        detailLabel.text = "01분 30초"
        
        let marginTop = pickerView.frame.height / 3 + 3
        let marginLeft = pickerView.frame.width / 3 + 20
        minLabel.topAnchor.constraint(equalTo: pickerView.topAnchor, constant: marginTop).isActive = true
        minLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: marginLeft).isActive = true
        
        secLabel.topAnchor.constraint(equalTo: pickerView.topAnchor, constant: marginTop + 0.5).isActive = true
        secLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: marginLeft * 2).isActive = true
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
        var label = self.detailLabel.text // "01분 30초"
        
        let minIndex = label?.index((label?.startIndex)!, offsetBy: 3)
        var minute = label?.substring(to: minIndex!)
        
        let secIndex = label?.index((label?.startIndex)!, offsetBy: 3)
        var second = label?.substring(from: secIndex!)
        
        if component == 0 {
            if row < 10 {
                minute = "0\(row)분"
            } else {
                minute = "\(row)분"
            }
        } else {
            if row < 10 {
                second = " 0\(row)초"
            } else {
                second = " \(row)초"
            }
        }
        label = minute! + second!
        self.detailLabel.text = label
        
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
