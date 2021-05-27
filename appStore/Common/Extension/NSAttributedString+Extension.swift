//
//  NSAttributedString+Extension.swift
//  appStore
//
//  Created by seoyeong on 2021/05/27.
//

import UIKit

extension NSAttributedString {
    
    public func height(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            context: nil)
        return ceil(boundingBox.height)
    }
    
}
