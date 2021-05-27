//
//  AppStoreResponse.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

struct AppStoreResponse: Codable {
    
    var screenshotUrls: [String]?
    var ipadScreenshotUrls: [String]?
    var appletvScreenshotUrls: [String]?
    var artworkUrl512: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var artistViewUrl: String?
    var supportedDevices: [String]?
    var advisories: [String]?
    var isGameCenterEnabled: Bool?
    var features: [String]?
    var kind: String?
    var minimumOsVersion: String?
    var languageCodesISO2A: [String]?
    var fileSizeBytes: String?
    var sellerUrl: String?
    var formattedPrice: String?
    var averageUserRatingForCurrentVersion: Double?
    var userRatingCountForCurrentVersion: Int?
    var trackContentRating: String?
    var averageUserRating: Double?
    var trackCensoredName: String?
    var trackViewUrl: String?
    var contentAdvisoryRating: String?
    var genreIds: [String]?
    var trackId: Int64?
    var trackName: String?
    var releaseDate: String?
    var sellerName: String?
    var primaryGenreName: String?
    var isVppDeviceBasedLicensingEnabled: Bool?
    var currentVersionReleaseDate: String?
    var releaseNotes: String?
    var primaryGenreId: Int64?
    var currency: String?
    var description: String?
    var artistId: Int64?
    var artistName: String?
    var genres: [String]?
    var price: Double?
    var bundleId: String?
    var version: String?
    var wrapperType: String?
    var userRatingCount: Int?

}
