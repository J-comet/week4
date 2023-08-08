//
//  WeatherViewController.swift
//  week4
//
//  Created by 장혜성 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {

    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(APIKey.openWeatherKey)"
    
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidtyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        
    }

    func callRequest() {
        AF.request(weatherUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
                let id = json["weather"][0]["id"].intValue
                
                print(temp, humidity, id)
                
                self.tempLabel.text = "\(temp)"
                self.humidtyLabel.text = "\(humidity)"
                
                switch id {
                case 800: self.weatherLabel.text = "매우맑음"
                case 801...899:
                    self.weatherLabel.text = "구름이 낀 날씨"
                    self.view.backgroundColor = .cyan
                default: print("default")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
