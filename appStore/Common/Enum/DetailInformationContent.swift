//
//  DetailInformationContent.swift
//  appStore
//
//  Created by seoyeong on 2021/05/27.
//

import Foundation

enum DetailInformationContent: CaseIterable {
    
    case Seller
    case Size
    case Category
    case SupportedDevice
    case Language
    case AdvisoryRating
    case CopyRight
    case DeveloperWebsite
    case PrivacyPolicy

    var title: String {
        switch self {
        case .Seller:
            return "제공자"
        case .Size:
            return "크기"
        case .Category:
            return "카테고리"
        case .SupportedDevice:
            return "호환성"
        case .Language:
            return "언어"
        case .AdvisoryRating:
            return "연령 등급"
        case .CopyRight:
            return "저작권"
        case .DeveloperWebsite:
            return "개발자 웹 사이트"
        case .PrivacyPolicy:
            return "개인정보 처리방침"
        }
    }

}
