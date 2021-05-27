//
//  ListViewModel.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

import RxSwift
import RxCocoa

class ListViewModel: BaseViewModel {
    
    private let repo = ListRepository()
    
    let dto: BehaviorRelay<[ListDTO]> = BehaviorRelay(value: [])
    
    private let data: BehaviorRelay<[AppStoreData]> = BehaviorRelay(value: [])
    
    func fetchHomeData(name: String = "", showLoading: Bool = true) {
        if showLoading {
            LoaderView.shared.show()
        }
        
        callDto(observableDto: repo.getAppStoreData(name: name)) { [weak self] data in
            guard let self = self else { return }
            
            let listDto: [ListDTO] = data.compactMap {
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
            self.dto.accept(listDto)
            self.data.accept(data)
        } onFailure: {
            if showLoading {
                LoaderView.shared.hide()
            }
        } onCompleted: {
            if showLoading {
                LoaderView.shared.hide()
            }
        }
    }

    func item(_ index: Int) -> AppStoreData {
        return data.value[index]
    }
    
}
