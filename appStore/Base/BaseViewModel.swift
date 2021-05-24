//
//  BaseViewModel.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import Foundation

import RxSwift
import RxCocoa

class BaseViewModel {
    let toastMessage: PublishRelay<String> = PublishRelay()
    let networkFailure: PublishRelay<ApiFailure> = PublishRelay()

    let bag = DisposeBag()
    
    func showToastMessage(message: String) {
        toastMessage.accept(message)
    }
    
    func showNetworkFailure(failure: ApiFailure) {
        networkFailure.accept(failure)
    }
    
    //행동/액션 API용 ex. POST, DELETE
    func call <T: Codable> (request: ResultObservable<T>, onSuccess: @escaping (ApiSuccess<T>) -> Void, onFailure: @escaping (ApiFailure) -> Void, onCompleted: (() -> Void)? = nil) {
        
        request.subscribe(onNext: { [weak self] result in
            switch result {
            case .apiSuccess(let success):
                onSuccess(success)
                print("success: \(success.statusCode)")
            case .apiFailure(let failure):
                onFailure(failure)
                print("failure: \(failure.statusCode) errorCode: \(failure.errorCode) errorMessage: \(failure.errorMessage)")
                self?.showToastMessage(message: failure.errorMessage)
            }
        }, onError: { [weak self] error in
            //called on no network
            onFailure(ApiFailure.noNetworkFailure)
            print("No Network Error: \(error.localizedDescription)")
            
            // to do ###
            self?.showToastMessage(message: "인터넷 연결이 끊어졌습니다.")
            
        }, onCompleted: {
            onCompleted?()
            print("onCompleted")
        }).disposed(by: bag)
    }
    
    //화면 렌더링 API용 ex.GET
    func callDto <T> (observableDto: Observable<ResultData<T>>, onSuccess: @escaping (T) -> Void, onFailure: @escaping () -> Void, onCompleted: (() -> Void)? = nil) {
        observableDto.subscribe(onNext: { [weak self] result in
            switch result {
            case .successData(let dto):
                onSuccess(dto)
            case .failureData:
                onFailure()
                self?.showNetworkFailure(failure: ApiFailure.defaultFailure)
            }
        }, onError: { error in
            //called on no network
            onFailure()
            self.showNetworkFailure(failure: ApiFailure.noNetworkFailure)
        }, onCompleted: {
            onCompleted?()
        }).disposed(by: bag)
    }
}
