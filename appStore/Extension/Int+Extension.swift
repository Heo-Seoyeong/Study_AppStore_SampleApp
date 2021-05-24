//
//  Int+Extension.swift
//  petpre
//
//  Created by YONGDOL on 2021/03/03.
//  Copyright © 2021 Funnc. All rights reserved.
//

import Foundation

extension Int {
    var decimalString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Int {
    var isSuccessCode: Bool {
        switch self {
        case 200 ... 299:
            return true
        default:
            return false
        }
    }
    
    var isFailCode: Bool {
        switch self {
        case 300 ... 599:
            return true
        default:
            return false
        }
    }
}
