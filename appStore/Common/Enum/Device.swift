//
//  Device.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

enum Devices: String {
    
    case iPhone = "iPhone"
    case iPad = "iPad"
    case iPod = "iPod"
    
    var title: String {
        switch self {
        case .iPhone:
            return "iPhone"
        case .iPad:
            return "iPad"
        case .iPod:
            return "iPod touch"
        }
    }
    
}
