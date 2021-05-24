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
    
    let getHomeData: PublishSubject<[ListDTO]> = PublishSubject()
    
    func fetchHomeData(name: String = "", showLoading: Bool = true) {
        if showLoading {
            LoaderView.shared.show()
        }
        
        callDto(observableDto: repo.getAppStoreData(name: name)) { [weak self] dto in
            self?.getHomeData.onNext(dto)
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
}
