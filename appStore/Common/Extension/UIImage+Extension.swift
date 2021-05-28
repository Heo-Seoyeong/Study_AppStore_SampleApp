//
//  UIImage+Extension.swift
//  appStore
//
//  Created by seoyeong on 2021/05/28.
//

import UIKit

extension UIImage {
 
    convenience init?(url: URL) {
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            self.init(data: data)
        } catch {
            self.init()
        }
    }
    
}
