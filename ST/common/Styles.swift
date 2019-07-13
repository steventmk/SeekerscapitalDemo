//
//  Styles.swift
//  ST
//
//  Created by Tao Man Kit on 11/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import Foundation

import UIKit

struct Styles {
    static let lastPriceNumberFormattor = NumberFormatter()
    static let changeNumberFormattor = NumberFormatter()
    static let decreasingColor = "ff4444"
    static let increasingColor = "00C851"
    static let neutralColor = "70c9df"
    
    static func setup() {
        lastPriceNumberFormattor.minimumFractionDigits = 1
        lastPriceNumberFormattor.minimumIntegerDigits = 1
        lastPriceNumberFormattor.maximumFractionDigits = 2
        
        changeNumberFormattor.minimumFractionDigits = 1
        changeNumberFormattor.minimumIntegerDigits = 1
        changeNumberFormattor.maximumFractionDigits = 3
    }
}
