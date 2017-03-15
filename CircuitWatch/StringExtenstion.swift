//
//  StringExtenstion.swift
//  CircuitWatch
//
//  Created by 홍창남 on 2017. 3. 15..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
