//
//  ListDTO.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

struct ListDTO {
    
    let searchName: String
    let trackName: String
    let artistName: String
    let averageUserRating: Double
    let userRatingCount: Int
    let appIcon: URL?
    let screenshotList: [URL]
    
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
    let trackViewUrl: URL?
    let artistViewUrl: URL?
    
}
