//
//  AppStoreApi.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

class AppStoreApi: ApiService {
    func getAppStoreInfo(name: String) -> ResultObservable<[AppStoreResponse]> {
        let path = "https://itunes.apple.com/search"
        return getTypeRequestData(type: [AppStoreResponse].self,
                                  path: path,
                                  method: .get,
                                  parameters: ["country": "kr",
                                               "media": "software",
                                               "term": name])
    }

}
