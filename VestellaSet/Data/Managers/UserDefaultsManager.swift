//
//  UserDefaultsManager.swift
//  VestellaSet
//
//  Created by 서충원 on 8/27/25.
//

import Foundation

@propertyWrapper
struct UserDefault {
    let key: String
    let defaultValue: Int
    
    var wrappedValue: Int {
        get { UserDefaults.standard.object(forKey: key).map { _ in UserDefaults.standard.integer(forKey: key) } ?? defaultValue }
    }
}

struct UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    @UserDefault(key: UserDefaultsKey.broadcastInterval, defaultValue: 1)
    var broadcastInterval: Int
    
    @UserDefault(key: UserDefaultsKey.transmissionPower, defaultValue: 1)
    var transmissionPower: Int
}
