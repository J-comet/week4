//
//  ViewController.swift
//  week4
//
//  Created by 장혜성 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Movie {
//    var showCnt: String
//    var movieCd: String
//    var salesAmt: String
//    var scrnCnt: String
//    var salesInten: String
//    var rank: String
//    var audiCnt: String
//    var audiChange: String
//    var rankInten: String
    var openDt: String
//    var salesShare: String
//    var salesChange: String
//    var salesAcc: String
    var movieNm: String
//    var rankOldAndNew: String
//    var audiAcc: String
//    var rnum: String
//    var audiInten: String
}

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        callRequest()
        
        searchBar.delegate = self
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 60
        
        indicatorView.isHidden = true
    }

    private func callRequest(targetDt: String) {
        
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(targetDt)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let arrMovie = json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue
                for item in arrMovie {
                    self.movieList.append(
                        Movie(openDt: item["openDt"].stringValue, movieNm: item["movieNm"].stringValue)
                    )
                }
                
//                let name1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let name2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let name3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//
//                self.movieList.append(name1)
//                self.movieList.append(name2)
//                self.movieList.append(name3)
                
                // 한꺼번에 추가하기
//                self.movieList.append(contentsOf: [name1, name2, name3])
                
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                
                self.movieTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        // 20221010
        callRequest(targetDt: searchBar.text!)
        searchBar.endEditing(true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = movieList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")!
        cell.textLabel?.text = row.movieNm
        cell.detailTextLabel?.text = row.openDt
        return cell
    }
    
}

