//
//  AppStoreData.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

struct AppStoreData {
        
    var screenshotUrls: [URL]
    var ipadScreenshotUrls: [URL]
    var appletvScreenshotUrls: [URL]
    var artworkUrl512: URL?
    var artworkUrl60: URL?
    var artworkUrl100: URL?
    var artistViewUrl: URL?
    var supportedDevices: [String]
    var advisories: [String]
    var isGameCenterEnabled: Bool
    var features: [String]
    var kind: String
    var minimumOsVersion: String
    var languageCodesISO2A: [String]
    var fileSizeBytes: String
    var sellerUrl: URL?
    var formattedPrice: String
    var averageUserRatingForCurrentVersion: Double
    var userRatingCountForCurrentVersion: Int
    var trackContentRating: String
    var averageUserRating: Double
    var trackCensoredName: String
    var trackViewUrl: URL?
    var contentAdvisoryRating: String
    var genreIds: [String]
    var trackId: Int64
    var trackName: String
    var releaseDate: Date
    var sellerName: String
    var primaryGenreName: String
    var isVppDeviceBasedLicensingEnabled: Bool
    var currentVersionReleaseDate: Date
    var releaseNotes: String
    var primaryGenreId: Int64
    var currency: String
    var description: String
    var artistId: Int64
    var artistName: String
    var genres: [String]
    var price: Double
    var bundleId: String
    var version: String
    var wrapperType: String
    var userRatingCount: Int
    
    init(_ app: AppStoreResponse) {
        
        self.screenshotUrls = app.screenshotUrls?.compactMap { URL(string: $0) } ?? []
        self.ipadScreenshotUrls = app.ipadScreenshotUrls?.compactMap { URL(string: $0) } ?? []
        self.appletvScreenshotUrls = app.appletvScreenshotUrls?.compactMap { URL(string: $0) } ?? []
        if let artworkUrl512 = app.artworkUrl512 { self.artworkUrl512 = URL(string: artworkUrl512) }
        if let artworkUrl60 = app.artworkUrl60 { self.artworkUrl60 = URL(string: artworkUrl60) }
        if let artworkUrl100 = app.artworkUrl100 { self.artworkUrl100 = URL(string: artworkUrl100) }
        if let artistViewUrl = app.artistViewUrl { self.artistViewUrl = URL(string: artistViewUrl) }
        self.supportedDevices = app.supportedDevices ?? []
        self.advisories = app.advisories ?? []
        self.isGameCenterEnabled = app.isGameCenterEnabled ?? false
        self.features = app.features ?? []
        self.kind = app.kind ?? ""
        self.minimumOsVersion = app.minimumOsVersion ?? ""
        self.languageCodesISO2A = app.languageCodesISO2A ?? []
        self.fileSizeBytes = app.fileSizeBytes ?? ""
        if let sellerUrl = app.sellerUrl { self.sellerUrl = URL(string: sellerUrl) }
        
        self.formattedPrice = app.formattedPrice ?? ""
        self.averageUserRatingForCurrentVersion = app.averageUserRatingForCurrentVersion ?? 0.0
        self.userRatingCountForCurrentVersion = app.userRatingCountForCurrentVersion ?? 0
        self.trackContentRating = app.trackContentRating ?? ""
        self.averageUserRating = app.averageUserRating ?? 0.0
        self.trackCensoredName = app.trackCensoredName ?? ""
        if let trackViewUrl = app.trackViewUrl { self.trackViewUrl = URL(string: trackViewUrl) }
        
        self.contentAdvisoryRating = app.contentAdvisoryRating ?? ""
        self.genreIds = app.genreIds ?? []
        self.trackId = app.trackId ?? 0
        self.trackName = app.trackName ?? ""
        
        self.releaseDate = Date.fromFormattedText(app.releaseDate, format: .iso3) ?? Date()
        self.sellerName = app.sellerName ?? ""
        self.primaryGenreName = app.primaryGenreName ?? ""
        self.isVppDeviceBasedLicensingEnabled = app.isVppDeviceBasedLicensingEnabled ?? false
        self.currentVersionReleaseDate = Date.fromFormattedText(app.currentVersionReleaseDate, format: .iso3) ?? Date()
        self.releaseNotes = app.releaseNotes ?? ""
        self.primaryGenreId = app.primaryGenreId ?? 0
        self.currency = app.currency ?? ""
        self.description = app.description ?? ""
        self.artistId = app.artistId ?? 0
        self.artistName = app.artistName ?? ""
        self.genres = app.genres ?? []
        self.price = app.price ?? 0.0
        self.bundleId = app.bundleId ?? ""
        self.version = app.version ?? ""
        self.wrapperType = app.wrapperType ?? ""
        self.userRatingCount = app.userRatingCount ?? 0
    }
    
}
