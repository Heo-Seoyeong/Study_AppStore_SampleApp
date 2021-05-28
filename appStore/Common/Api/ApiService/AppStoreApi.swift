//
//  AppStoreApi.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

class AppStoreApi: ApiService {
    func getAppStoreInfo(name: String) -> ResultObservable<AppStoreRootResponse> {
        let path = "https://itunes.apple.com/search"
        return getTypeRequestData(type: AppStoreRootResponse.self,
                                  path: path,
                                  method: .get,
                                  parameters: ["country": "kr",
                                               "media": "software",
                                               "term": name])
    }

}
