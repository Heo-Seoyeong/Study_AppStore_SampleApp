//
//  ListDTO.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

struct ListDTO {
    
    var searchName: String
    var trackName: String
    var artistName: String
    var averageUserRating: Double
    var userRatingCount: Int
    var appIcon: URL?
    var screenshotList: [URL]
    
}
