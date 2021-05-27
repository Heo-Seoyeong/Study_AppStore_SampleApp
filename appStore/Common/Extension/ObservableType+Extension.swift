//
//  ObservableType.swift
//  StudyMvvmSample
//
//  Created by Minchae Jeong on 2021/01/16.
//

import RxSwift

extension ObservableType {
    public func mapCodable<T: Codable>(type: T.Type) -> Observable<ApiResult<ApiSuccess<T>, ApiFailure>> {
        return flatMap { data -> Observable<ApiResult<ApiSuccess<T>, ApiFailure>> in
            do {
                let responseTuple = data as! (response: HTTPURLResponse, data: Data)
                let statusCode = responseTuple.response.statusCode
                let jsonData = responseTuple.data
                
                if (statusCode.isSuccessCode) {
                    let object = try JSONDecoder().decode(T.self, from: jsonData)
                    let success = ApiSuccess(statuscode: statusCode, data: object)
                    let result = ApiResult<ApiSuccess<T>, ApiFailure>.apiSuccess(success)
                    return Observable.just(result)
                } else {
                    let apiError = try JSONDecoder().decode(ApiError.self, from: jsonData)
                    
                    
                    if apiError.errorCode.uppercased() == "INVALID_MOBILE_APP_DEVICE_TOKEN_ID" {
//                        PetPreAPI.call(AppAPI.registerDeviceToken(token: DeviceTokenManager.deviceToken), for: DeviceTokenModel.self) { (result) in
//                            if case .success(let deviceTokenModel) = result {
//                                guard let deviceTokenModel = deviceTokenModel else { return }
//                                guard let deviceToken = DeviceToken(deviceTokenModel: deviceTokenModel) else { return }
//                                DeviceTokenManager.setDeviceTokenId(deviceToken.id)
//                            }
//                        }
                        let failure = ApiFailure(statusCode: statusCode, errorCode: apiError.errorCode, errorMessage: "일시적인 오류가 발생하였습니다. 다시 시도해 주세요.")
                        let result = ApiResult<ApiSuccess<T>, ApiFailure>.apiFailure(failure)
                        return Observable.just(result)
                    } else {
                        let failure = ApiFailure(statusCode: statusCode, errorCode: apiError.errorCode, errorMessage: apiError.errorMessage)
                        let result = ApiResult<ApiSuccess<T>, ApiFailure>.apiFailure(failure)
                        return Observable.just(result)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                let result = ApiResult<ApiSuccess<T>, ApiFailure>.apiFailure(ApiFailure.defaultFailure)
                return Observable.just(result)
            }
        }
    }
 
    func listen(bag: DisposeBag, onNext: @escaping (Element) -> Void) {
        self.asObservable().subscribe(onNext: { newValue in
            onNext(newValue)
        }).disposed(by: bag)
    }
    
    func printLog(data: Data?, response: URLResponse?) {
        let urlString = response?.url?.absoluteString
        let components = URLComponents(string: urlString ?? "")
        
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        
        var responseLog = "\n<---------- IN ----------\n"
        if let urlString = urlString {
            responseLog += "\nIN:\t\t\(urlString)\nIN:\t\t\n"
        }
        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            responseLog += "IN:\t\tHTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            responseLog += "IN:\t\tHost: \(host)\nIN:\t\t\n"
        }
        
        responseLog += "IN:\t\t<Headers>\n"
        (response as? HTTPURLResponse)?.allHeaderFields.forEach {
            responseLog += "IN:\t\t\($0.key): \($0.value)\n"
        }
        
        if let bodyData = data {
            responseLog += "IN:\t\t\nIN:\t\t<Body>\n"
            let body = bodyData.prettyPrintedJSON ?? "Can't render body; not utf8 encoded"
            responseLog += "IN:\t\t\(body.replacingOccurrences(of: "\n", with: "\nIN:\t\t"))\n"
        }
        
        responseLog += "\n<-------------------------\n"
        print(responseLog)
    }
}


