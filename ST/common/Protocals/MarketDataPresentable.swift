//
//  File.swift
//  ST
//
//  Created by Tao Man Kit on 11/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import Foundation

protocol MarketDataPresentable {
    func countChange(open: Double, close: Double) -> Double
    func countChangePercent(open: Double, close: Double) -> Double
    func formatLastPrice(_ value: Double) -> String
    func formatChange(_ value: Double) -> String
    func formatChangePercent(_ value: Double) -> String
    func colorCode(_ value: Double) -> String
}

extension MarketDataPresentable {
    func countChange(open: Double, close: Double) -> Double {
        return close - open
    }
    
    func countChangePercent(open: Double, close: Double) -> Double {
        return ((close - open) / open) * 100
    }
    
    func formatLastPrice(_ value: Double) -> String {
        if let formattedValue = Styles.lastPriceNumberFormattor.string(from: NSNumber(value: value)) {
            return String(formattedValue)
        } else {
            return "-"
        }
    }
    
    func formatChange(_ value: Double) -> String {
        if let formattedValue = Styles.changeNumberFormattor.string(from: NSNumber(value:value)) {
            return String(formattedValue)
        } else {
            return "-"
        }
    }
    
    func formatChangePercent(_ value: Double) -> String {
        if let formattedValue = Styles.changeNumberFormattor.string(from: NSNumber(value:value)) {
            return String(formattedValue) + "%"
        } else {
            return "-"
        }
    }
    
    func colorCode(_ value: Double) -> String {
        if value > 0 {
            return Styles.increasingColor
        } else if value < 0 {
            return Styles.decreasingColor
        } else {
            return Styles.neutralColor
        }
    }
}
