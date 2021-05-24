//
//  String+Extension.swift
//  petpre
//
//  Created by Paul Kim on 2020/03/23.
//  Copyright © 2020 Funnc. All rights reserved.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String {
    var url: URL? {
        return URL(string: self)
    }
}

extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }

        return attributedString.string
    }
}

extension String {
    var isOnlyNumbers: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    var convertGA: String {
        return self.replacingOccurrences(of: "[^a-zA-Z0-9]", with: "_", options: .regularExpression)
    }
}
