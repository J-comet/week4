//
//  VideoViewController.swift
//  week4
//
//  Created by 장혜성 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Video {
    let author: String
    let date: String
    let runTime: Int
    let thumbnail: String
    let title: String
    let link: String
    
    var contents: String {
        return "\(author) | \(runTime)회 \n\(date)"
    }
}

class VideoViewController: UIViewController {
    
    var videoList: [Video] = [] {
        didSet {
            videoTableView.reloadData()
        }
    }
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    var page = 1
    var isEnd = false  // 페이징 체크
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 140
    }

    private func callRequest(page: Int, query: String) {
        KakaoAPIManager.shared.callRequest(type: .video, query: query) { JSON in
            print(JSON)
//            let statusCode = JSON.response?.statusCode ?? 500
            
            self.isEnd = JSON["meta"]["is_end"].boolValue
            
            for item in JSON["documents"].arrayValue {
                let video = Video(
                    author: item["author"].stringValue,
                    date: item["datetime"].stringValue,
                    runTime: item["play_time"].intValue,
                    thumbnail: item["thumbnail"].stringValue,
                    title: item["title"].stringValue,
                    link: item["url"].stringValue)

                self.videoList.append(video)
//                        print(self.videoList)
            }
        }
        
//        AF.request(url, method: .get, headers: header)
//            .validate(statusCode: 200...500)
//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print(response.response?.statusCode)
//                // validate 범위를 늘리면 다른 statusCode 를 예외처리 할 수 있음.
//
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

// UITableViewDataSourcePrefetching: iOS 10 이상 사용 가능한 프로토콜, cellForRowAt 메서드가 호출 되기 전에 미리 호출 됨.
extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능 = 미리 다운로드
    // videoList 갯수와 indexPath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청
    // pageCount
    // isEnd
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if videoList.count - 1 == indexPath.row && page < 15 && !isEnd {
                page += 1
                callRequest(page: page, query: searchBar.text!)
            }
        }
    }
    
    // 취소 기능: 직접 취소하는 기능을 구현해주어야 함!
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    // cellForRowAt: 눈에 보일 때 , 용량이 큰 것을 불러올 때 유저는 많이 기다려야될 수도 있음
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = videoList[indexPath.row].title
        cell.contentLabel.text = videoList[indexPath.row].contents
        
        if let url = URL(string: videoList[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        
        return cell
    }
}

extension VideoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        videoList.removeAll()
        page = 1
        guard let query = searchBar.text else { return }
        callRequest(page: page, query: query)
        searchBar.endEditing(true)
    }
}
