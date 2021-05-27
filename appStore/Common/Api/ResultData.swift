//
//  ResultData.swift
//  StudyMvvmSample
//
//  Created by Minchae Jeong on 2021/01/16.
//
import RxSwift
import RxCocoa

public enum ResultData<Element> {
    case successData(Element)
    case failureData
    
    var asObservable: Observable<ResultData<Element>> {
        return Observable.just(self)
    }
}
