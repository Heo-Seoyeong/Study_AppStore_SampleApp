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

extension Date {
    func addedBy(byAdding: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: byAdding, value: value, to: self)!
    }

    func years(from date: Date) -> Int{
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }

    func months(from date: Date) -> Int{
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }

    func weeks(from date: Date) -> Int{
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }

    func days(from date: Date) -> Int{
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }

    func hours(from date: Date) -> Int{
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }

    func minutes(from date: Date) -> Int{
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    func seconds(from date: Date) -> Int{
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }

    func offset(from date: Date) -> String {
        if years(from: date) > 0 { return "\(years(from: date))년 전" }
        if months(from: date) > 0 { return "\(months(from: date))개월 전" }
        if weeks(from: date) > 0 { return "\(weeks(from: date))주 전" }
        if days(from: date) > 0 { return "\(days(from: date))일 전" }
        if hours(from: date) > 0 { return "\(hours(from: date))시간 전" }
        if minutes(from: date) > 0 { return "\(minutes(from: date))분 전" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))초 전" }
        return ""
    }
}
