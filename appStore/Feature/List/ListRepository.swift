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
    
    func getAppStoreData(name: String) -> Observable<ResultData<[AppStoreData]>> {
        return AppStoreApi().getAppStoreInfo(name: name).map { appStoreInfoList -> ResultData<[AppStoreData]> in
            if case .apiSuccess(let appStoreInfoList) = appStoreInfoList {
                let appStoreDataList = appStoreInfoList.data.compactMap { AppStoreData($0) }
                return ResultData.successData(appStoreDataList)
            } else {
                return ResultData.failureData
            }
        }
        
        
    }
    
}
