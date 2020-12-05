//
//  UserDefaults.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/29.
//

import Foundation
import SwiftyUserDefaults

extension UserDefaults {
    // 登录信息
    struct LoginInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case session
        }
    }
}



protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue == String {
    static func set(value: String?, forKey key: defaultKeys) {
        let akey = key.rawValue
        UserDefaults.standard.setValue(value, forKey: akey)
    }
    
    static func string(forKey key: defaultKeys) -> String {
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey) ?? ""
    }
}
