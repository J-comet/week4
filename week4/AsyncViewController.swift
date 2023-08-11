//
//  AsyncViewController.swift
//  week4
//
//  Created by 장혜성 on 2023/08/11.
//

import UIKit

class AsyncViewController: UIViewController {

    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topImageView.backgroundColor = .black
        DispatchQueue.main.async {
            self.topImageView.layer.cornerRadius = self.topImageView.frame.width / 2
        }
//        topImageView.layer.cornerRadius = topImageView.frame.width / 2  // topImageView 원으로 만들기 위해 기기별로 달라지는 width 값으로 계산
        
    }
    
    // sync , async , serial , concurrent
    // UI Freezing
    @IBAction func buttonClicked(_ sender: UIButton) {
        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")!
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            
            // UI 와 관련된 작업은 메인스레드!!
            DispatchQueue.main.async {      // 메인스레드
                self.topImageView.image = UIImage(data: data)
            }
        }
        
    }
    
}
