//
//  ReusableViewProtocol.swift
//  week4
//
//  Created by 장혜성 on 2023/08/11.
//


import UIKit


/**
 protocol + extension  으로  ReusableViewProtocol 을 ViewController or TableViewCell identifier 자동으로 만들어지도록!!!
 */
protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
