//
//  ListRepository.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

import RxSwift
import RxCocoa

class ListRepository {
    
    let appStoreApiService = AppStoreApi()
    
    func getAppStoreData(name: String) -> Observable<ResultData<[ListDTO]>> {
        return AppStoreApi().getAppStoreInfo(name: name).map { appStoreInfoList -> ResultData<[ListDTO]> in
            if case .apiSuccess(let appStoreInfoList) = appStoreInfoList {
                let appStoreDataList = appStoreInfoList.data.results.compactMap { AppStoreData($0) }
                let dto: [ListDTO] = appStoreDataList.compactMap {
                    var screenshotList = [URL]()
                    switch UIDevice.current.userInterfaceIdiom {
                    case .phone: screenshotList = $0.screenshotUrls.compactMap { $0 }
                    case .pad: screenshotList = $0.ipadScreenshotUrls.compactMap { $0 }
                    default: break
                    }
                    
                    return ListDTO(searchName: name,
                                   trackName: $0.trackName,
                                   artistName: $0.artistName,
                                   averageUserRating: $0.averageUserRating,
                                   userRatingCount: $0.userRatingCount,
                                   appIcon: $0.artworkUrl512,
                                   screenshotList: screenshotList,
                                   genre: $0.genres.first ?? "",
                                   contentAdvisoryRating: $0.contentAdvisoryRating,
                                   ipadScreenshotUrls: $0.ipadScreenshotUrls,
                                   screenshotUrls: $0.screenshotUrls,
                                   description: $0.description,
                                   version: $0.version,
                                   releaseDate: $0.releaseDate,
                                   releaseNotes: $0.releaseNotes,
                                   sellerName: $0.sellerName,
                                   fileSizeBytes: $0.fileSizeBytes,
                                   genres: $0.genres,
                                   supportedDevices: $0.supportedDevices,
                                   minimumOsVersion: $0.minimumOsVersion,
                                   languageCodesISO2A: $0.languageCodesISO2A,
                                   sellerUrl: $0.sellerUrl,
                                   trackViewUrl: $0.trackViewUrl,
                                   artistViewUrl: $0.artistViewUrl)
                }
                return ResultData.successData(dto)
            } else {
                return ResultData.failureData
            }
        }
        
        
    }
    
}
