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
    
    
    var isObserving = false;
    
    // initialize pickerView delegate, dataSource
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
    }
    
    // tableViewCell's height setup
    class var expandedHeight: CGFloat { get { return 200 } }
    class var defaultheight: CGFloat { get { return 44 } }
    
    func checkHeight() {
        pickerView.isHidden = (frame.height < FormCell.expandedHeight)
    }
    
    
    // for pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Detail\(row)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        detailLabel.text = "Detail\(row)"
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
