//
//  ListViewModel.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

import RxSwift
import RxCocoa
import RxDataSources

class ListViewModel: BaseViewModel {
    
    enum ListInfo {
        case recent(String)
        case search(ListDTO)
        case noresult
    }
    
    let dto: BehaviorRelay<[SectionModel<String, ListInfo>]> = BehaviorRelay(value: [])
    
    func action(name: String = "") {
        if name.isEmpty {
            self.fetchRecentData()
        } else {
            self.fetchAppStoreData(name: name)
        }
        
    }
    
    private func fetchAppStoreData(name: String = "", showLoading: Bool = true) {
        if showLoading {
            LoaderView.shared.show()
        }
        
        callDto(observableDto: ListRepository().getAppStoreData(name: name)) { [weak self] dto in
            self?.saveRecent(name)
            
            if dto.isEmpty {
                let model = [SectionModel<String, ListInfo>(model: "결과 없음", items: [ListInfo.noresult])]
                self?.dto.accept(model)
            } else {
                let model = [SectionModel<String, ListInfo>(model: "검색 결과", items: dto.compactMap { ListInfo.search($0) })]
                self?.dto.accept(model)
            }
            
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
    
    private func fetchRecentData() {
        let recents: [String] = []
        let model = [SectionModel<String, ListInfo>(model: "최근 검색어", items: recents.compactMap { ListInfo.recent($0) })]
        self.dto.accept(model)
    }
    
    private func saveRecent(_ keyword: String) {
        guard !keyword.isEmpty else { return }
    }
    
}
