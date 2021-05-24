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
                let appStoreDataList = appStoreInfoList.data.compactMap { AppStoreData($0) }
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
                                   screenshotList: screenshotList)
                }
                return ResultData.successData(dto)
            } else {
                return ResultData.failureData
            }
        }
        
        
    }
    
}
