//
//  UserDefaultsManager.swift
//  VestellaSet
//
//  Created by 서충원 on 8/27/25.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    @UserDefault(key: UserDefaultsKey.uuid, defaultValue: Vestella.uuid)
    var uuid: String
    
    @UserDefault(key: UserDefaultsKey.broadcastInterval, defaultValue: 1)
    var broadcastInterval: Int
    
    @UserDefault(key: UserDefaultsKey.transmissionPower, defaultValue: 1)
    var transmissionPower: Int
    
    @UserDefault(key: UserDefaultsKey.targetList, defaultValue: [])
    var targetList: [String]
}
