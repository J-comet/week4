//
//  KakaoAPIManager.swift
//  week4
//
//  Created by 장혜성 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    let header: HTTPHeaders = ["Authorization":"KakaoAK \(APIKey.kakaoRESTKey)"]
    
    static let shared = KakaoAPIManager()
    private init(){}
    
    func callRequest(type: Endpoint,query: String, completionHandler: @escaping (JSON) -> ()) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
//        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)"
        
        let url = type.requestURL + text
        print("url = ", url)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
