//
//  AllOptionalJsonParser.swift
//  PetPre
//
//  Created by Minchae Jeong on 2021/01/17.
//
import Foundation

public struct UnwrapError<T> : Error, CustomStringConvertible {
    let optional: T?

    public var description: String {
        return "Found nil while unwrapping \(String(describing: optional))!"
    }
}

func unwrap<T>(_ optional: T?) throws -> T {
    if let real = optional {
        return real
    } else {
        throw UnwrapError(optional: optional)
    }
}

extension Optional {
    func orThrow() throws -> Wrapped {
        guard let value = self else {
            throw UnwrapError(optional: self)
        }
        return value
    }
}

///JSON 형태의 primitive data type만 안전하게 unwrap하는 함수들.
extension Optional where Wrapped == String {
    func orDefault() -> String {
        if let value = self {
            return value
        }
        return ""
    }

    func unwrapSafelyWithDefault() -> String {
        if let value = self {
            return value
        }
        return ""
    }
    
    func unwrapSafelyThrowable() throws -> String {
        if let value = self {
            return value
        }
        throw UnwrapError(optional: self)
    }
    
    func toUrl() -> URL? {
        if let value = self {
            return URL(string: value)
        }
        return nil
    }
}

extension Optional {
    func isNil<Wrapped>(value: Wrapped) -> Wrapped {
        if self != nil {
            return self as! Wrapped
        }
        return value
    }
}

extension Optional where Wrapped == Int {
    func orDefault() -> Int {
        if let value = self {
            return value
        }
        return 0
    }
    
    func unwrapSafelyWithDefault() -> Int {
        if let value = self {
            return value
        }
        return 0
    }
    
    func unwrapSafelyThrowable() throws -> Int {
        if let value = self {
            return value
        }
        throw UnwrapError(optional: self)
    }
}

protocol OptionalType {
  associatedtype Wrapped
  var optional: Wrapped? { get }
}

extension Optional: OptionalType {
  var optional: Self { self }
}

extension Array where Element: OptionalType {

}

extension Optional where Wrapped == Array<String> {
    func orDefault() -> Array<String> {
        if let value = self {
            return value
        }
        return []
    }
    
    func toUrlArray() -> Array<URL> {
        return self?.compactMap { URL(string: $0) } ?? []
    }
}

extension Optional where Wrapped == Array<Int> {
    func orDefault() -> Array<Int> {
        if let value = self {
            return value
        }
        return []
    }
}
