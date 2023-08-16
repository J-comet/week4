//
//  EndPoint.swift
//  week4
//
//  Created by 장혜성 on 2023/08/11.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    case video
    
    var requestURL: String {
        switch self {
        case .blog: return URL.makeEndPointString("blog?query=")
        case .cafe: return URL.makeEndPointString("cafe?query=")
        case .video: return URL.makeEndPointString("vclip")
        }
    }
}
