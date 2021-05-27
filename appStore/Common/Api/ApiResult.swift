//
//  Result.swift
//  StudyMvvmSample
//
//  Created by Minchae Jeong on 2021/01/16.
//

public enum ApiResult<Success, Failure> {
    case apiSuccess(Success)
    case apiFailure(Failure)
    
    //때로는 enum 클래스 처럼... 때로는 optional 로 바로 value값 참조가 가능하게끔...
    //유연하게 사용하기 위해서 추가했다.
    var apiSuccess: Success? {
        switch self {
        case .apiSuccess(let value): return value
        case .apiFailure(_): return nil
        }
    }
    
    var apiFailure: Failure? {
        switch self {
        case .apiSuccess(_): return nil
        case .apiFailure(let value): return value
        }
    }
}

public class ApiSuccess<Element> {
    let statusCode: Int
    let data: Element
    
    init(statuscode: Int, data: Element) {
        self.statusCode = statuscode
        self.data = data
    }
}

public class ApiFailure : Error {
    
    static let defaultFailure = ApiFailure(statusCode: 2580, errorCode: "Default_Error_Code", errorMessage: "Default_Error_Message")
    
    static let noNetworkFailure = ApiFailure(statusCode: 1802, errorCode: "NO_NETWORK", errorMessage: "네트워크가 없습니다.")
    
    let statusCode: Int
    let errorCode: String
    let errorMessage: String
    
    init(statusCode: Int, errorCode: String, errorMessage: String) {
        self.statusCode = statusCode
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
    
}

