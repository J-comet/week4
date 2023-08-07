//
//  ViewController.swift
//  week4
//
//  Created by 장혜성 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=20230111"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
    }

    private func callRequest() {
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let name = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
                print(name, "떴냐 ???")
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

