//
//  Stock.swift
//  ST
//
//  Created by Tao Man Kit on 7/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import Foundation

struct Stock: Codable, Model {
    var name: String
    var code: String
    var close: Double
    var low: Double
    var high: Double
    var open: Double
}

