//
//  TranslationViewController.swift
//  week4
//
//  Created by 장혜성 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationViewController: UIViewController {

    @IBOutlet var originTextView: UITextView!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet var transButton: UIButton!
    
    let header: HTTPHeaders = [
        "X-Naver-Client-Id" : APIKey.naverClientID,
        "X-Naver-Client-Secret" : APIKey.naverSecret
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTextView.isEditable = false
    }
    
    @IBAction func transButtonClicked(_ sender: UIButton) {
        callDetectLangs()
//        callTransRequest()
    }
    
    func callDetectLangs() {
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let parameters: Parameters = [
            "query" : originTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let lang = json["langCode"].stringValue
                self.callTransRequest(source: lang)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callTransRequest(source: String) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let parameters: Parameters = [
            "source" : source,
            "target" : "ko",
            "text" : originTextView.text ?? ""
        ]
        
        if source == "ko" {
            self.resultTextView.text = "번역하려는 언어와 동일합니다"
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                var json = JSON(value)
                print(json)
                
                self.resultTextView.text = json["message"]["result"]["translatedText"].stringValue
            case .failure(let error):
                print(error)
            }
        }
    }
}
