//
//  Date+Extension.swift
//  petpre
//
//  Created by Paul Kim on 2020/03/09.
//  Copyright © 2020 Funnc. All rights reserved.
//

import Foundation

extension Date {
    enum Format: String {
        //TODO: $$ replace with string key value
        case currentLanguage = "yyyy년 M월"
        case currentLanguageMonthAndDate = "M월 d일"
        case dayOfTheWeek = "EEEE"
        case yearMonthDay = "yyyy.MM.dd"
        case yearMonth = "yyyy.MM"
        case monthDay = "MM.dd"
        case birthday = "yyyy-MM"
        case iso = "yyyy-MM-dd'T'HH:mm:ss"
        case iso2 = "yyyy.MM.dd HH:mm"
        case iso3 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case yearMonthDayEndComma = "yyyy.MM.dd."
        
    }
    
    func string(format: Format) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

extension Date {
    var year: Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.year, from: self)
    }
    
    var month: Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.month, from: self)
    }
    
    var day: Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.day, from: self)
    }
}

extension Date {
    static func fromFormattedText(_ text: String?, format: Format) -> Date? {
        guard let text = text else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: text)
    }
}

extension Date {
    static func yearAndMonthDate(year: Int, month: Int) -> Date {
        return Date.fromFormattedText("\(year)-\(month)", format: .birthday) ?? Date()
    }
}
