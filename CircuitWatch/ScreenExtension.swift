//
//  ScreenExtension.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 3. 9..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import UIKit

extension UIDevice {
    public var isiPhoneSE: Bool {
        return compare(height: 568, width: 320)
    }
    public var isiPhonePlus: Bool {
        return compare(height: 736, width: 414)
    }
    
    public var isiPad: Bool {
        return compare(height: 1024, width: 768)
    }
    public var isiPadPro12: Bool {
        return compare(height: 1366, width: 1366)
    }
    
    private func compare(height: CGFloat, width: CGFloat) -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == height || UIScreen.main.bounds.size.width == width) {
            return true
        }
        return false
    }
}
