//
//  TranslateAPIManager.swift
//  week4
//
//  Created by 장혜성 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslateAPIManager {
    
    let header: HTTPHeaders = [
        "X-Naver-Client-Id" : APIKey.naverClientID,
        "X-Naver-Client-Secret" : APIKey.naverSecret
    ]
    
    static let shared = TranslateAPIManager()
    private init(){}
    
    func callDetectLangsRequest(text: String, resultLangs: @escaping (String) -> Void) {
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let parameters: Parameters = [
            "query" : text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let lang = json["langCode"].stringValue
                resultLangs(lang)
//                self.callTransRequest(source: lang)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
