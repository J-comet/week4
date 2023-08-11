//
//  UserDefaultsHelper.swift
//  week4
//
//  Created by 장혜성 on 2023/08/11.
//

import Foundation


class UserDefaultsHelper {  // PropertyWrapper
    
    static let standard = UserDefaultsHelper()  // 싱글턴 패턴
    
    // 다른 곳에서는 인스턴스를 생성하지 못하도록 접근 제어자로 막기
    // 문법적으로 초기화를 하지 못하도록 막음
    private init() {}
    
    let userDefaults = UserDefaults.standard
    
    /**
     필요한 곳에서만 사용할 수 있도록 열거형을 사용할 수 있는 곳을 한정적으로 만듬.
     (컴파일 최적화)
     */
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
