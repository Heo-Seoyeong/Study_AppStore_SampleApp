//
//  AppStoreResponse.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

struct AppStoreRootResponse: Codable {
    
    let resultCount: Int
    let results: [AppStoreResponse]
    
}


struct AppStoreResponse: Codable {
    
    let screenshotUrls: [String]?
    let ipadScreenshotUrls: [String]?
    let appletvScreenshotUrls: [String]?
    let artworkUrl512: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
    let supportedDevices: [String]?
    let advisories: [String]?
    let isGameCenterEnabled: Bool?
    let features: [String]?
    let kind: String?
    let minimumOsVersion: String?
    let languageCodesISO2A: [String]?
    let fileSizeBytes: String?
    let sellerUrl: String?
    let formattedPrice: String?
    let averageUserRatingForCurrentVersion: Double?
    let userRatingCountForCurrentVersion: Int?
    let trackContentRating: String?
    let averageUserRating: Double?
    let trackCensoredName: String?
    let trackViewUrl: String?
    let contentAdvisoryRating: String?
    let genreIds: [String]?
    let trackId: Int64?
    let trackName: String?
    let releaseDate: String?
    let sellerName: String?
    let primaryGenreName: String?
    let isVppDeviceBasedLicensingEnabled: Bool?
    let currentVersionReleaseDate: String?
    let releaseNotes: String?
    let primaryGenreId: Int64?
    let currency: String?
    let description: String?
    let artistId: Int64?
    let artistName: String?
    let genres: [String]?
    let price: Double?
    let bundleId: String?
    let version: String?
    let wrapperType: String?
    let userRatingCount: Int?

}
