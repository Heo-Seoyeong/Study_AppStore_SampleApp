//
//  ApiService.swift
//  StudyMvvmSample
//
//  Created by Minchae Jeong on 2021/01/16.
//

import RxSwift

import RxAlamofire
import Alamofire

typealias ResultObservable<T> = Observable<ApiResult<ApiSuccess<T>, ApiFailure>>

class ApiService {
    
    public func getTypeRequestData <T: Codable> (type: T.Type, path: String, method: HTTPMethod, parameters: [String : Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default) -> ResultObservable<T> {
        
//        let url = "\(BASE_URL)\(path)"
        let url = path
        
        var request = URLRequest(url: URL(string: url)!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        
        switch method {
        case .get, .head, .delete:
            request = urlParameterEncode(urlRequest: request, with: parameters)
        default:
            if let parameters = parameters {
                request = jsonParameterEncode(urlRequest: request, with: parameters)
            }
        }
        
        return RxAlamofire.requestData(request).mapCodable(type: type)
    }
    
    private func jsonParameterEncode(urlRequest: URLRequest, with parameters: Parameters?) -> URLRequest {
        var urlRequest = urlRequest
        if let parameters = parameters,
            let jsonAsData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        {
            urlRequest.httpBody = jsonAsData
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return urlRequest
    }
    
    private func urlParameterEncode(urlRequest: URLRequest, with parameters: Parameters?) -> URLRequest {
        var urlRequest = urlRequest
        guard let url = urlRequest.url else { return urlRequest }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), let parameters = parameters, parameters.isEmpty == false {
            urlComponents.queryItems = []
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        return urlRequest
    }
    
}
