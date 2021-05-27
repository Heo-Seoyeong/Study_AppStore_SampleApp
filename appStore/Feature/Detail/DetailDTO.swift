//
//  DetailDTO.swift
//  appStore
//
//  Created by seoyeong on 2021/05/27.
//

import Foundation

struct DetailDTO {

    let trackName: String
    let artistName: String
    let appIcon: URL?
    let averageUserRating: Double
    let userRatingCount: Int
    let genre: String
    let contentAdvisoryRating: String
    let ipadScreenshotUrls: [URL]
    let screenshotUrls: [URL]
    let description: String
    let version: String
    let releaseDate: Date
    let releaseNotes: String
    let sellerName: String
    let fileSizeBytes: String
    let genres: [String]
    let supportedDevices: [String]
    let minimumOsVersion: String
    let languageCodesISO2A: [String]
    let sellerUrl: URL?
    let shareUrl: URL?

    init(_ data: AppStoreData) {
        trackName = data.trackName
        artistName = data.artistName
        appIcon = data.artworkUrl512
        averageUserRating = data.averageUserRating
        userRatingCount = data.userRatingCount
        genre = data.genres.first ?? ""
        contentAdvisoryRating = data.contentAdvisoryRating
        ipadScreenshotUrls = data.ipadScreenshotUrls
        screenshotUrls = data.screenshotUrls
        description = data.description
        version = data.version
        releaseDate = data.releaseDate
        releaseNotes = data.releaseNotes
        sellerName = data.sellerName
        fileSizeBytes = data.fileSizeBytes
        genres = data.genres
        supportedDevices = data.supportedDevices
        minimumOsVersion = data.minimumOsVersion
        languageCodesISO2A = data.languageCodesISO2A
        sellerUrl = data.sellerUrl
        shareUrl = data.trackViewUrl
    }
    
    func detailContents() -> [(DetailInformationContent, String)] {
        return DetailInformationContent.allCases.compactMap { type in
            var value: String?
            switch type {
            case .Seller:
                value = self.sellerName
            case .Size:
                value = descBytes(self.fileSizeBytes)
            case .Category:
                value = self.genres.joined(separator: ", ")
            case .SupportedDevice:
                value = descSupportedDevice(self.supportedDevices, self.minimumOsVersion)
            case .Language:
                value = descLanguage(self.languageCodesISO2A)
            case .AdvisoryRating:
                value = self.contentAdvisoryRating
            case .CopyRight:
                value = "©️ \(self.sellerName)"
            case .DeveloperWebsite:
                value = self.sellerUrl != nil ? "" : nil
            case .PrivacyPolicy:
                value = ""
            
            }
            
            if let value = value {
                return (type, value)
            }
            return nil
        }
    }
    
}

extension DetailDTO {
    
    func descBytes(_ bytes: String) -> String {
        if let bytes = Float(bytes) {
            return "\(round(bytes / 1024.0 / 1024.0 * 10) / 10)MB"
        } else {
            return bytes + "Byte"
        }

    }
    
    func descSupportedDevice(_ devices: [String], _ minimumOsVersion: String) -> String {
        let enableDevices: [Devices] = Array(Set(devices.compactMap {
            if $0.contains(Devices.iPhone.rawValue) {
                return .iPhone
            }
            if $0.contains(Devices.iPad.rawValue) {
                return .iPad
            }
            if $0.contains(Devices.iPod.rawValue) {
                return .iPod
            }
            return nil
        }))
        
        var deviceDesc: String = "iOS \(minimumOsVersion) 버전 이상이 필요."
        
        enableDevices.enumerated().forEach { index, device in
            if index == 0 {
                deviceDesc += " " + device.title
            } else if index == enableDevices.count - 1 {
                deviceDesc += " 및 \(device.title)와(과) 호환."
            } else {
                deviceDesc += ", \(device.title)"
            }
        }

        return deviceDesc
    }
    
    func descLanguage(_ languages: [String]) -> String {
        return languages.reduce("") {
            let language = Locale.current.localizedString(forIdentifier: $1) ?? ""
            if $0.isEmpty {
                return $0 + language
            } else {
                return $0 + ", \(language)"
            }
        }
    }
    
}
