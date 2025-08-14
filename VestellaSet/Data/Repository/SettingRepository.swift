//
//  SettingRepository.swift
//  VestellaSet
//
//  Created by 서충원 on 8/12/25.
//

import Foundation

class SettingRepository {
    @UserDefault(key: UserDefaultsKey.uuid, defaultValue: Vestella.uuid)
    var uuid: String
    
    @UserDefault(key: UserDefaultsKey.broadcastInterval, defaultValue: 1)
    var broadcastInterval: Int
    
    @UserDefault(key: UserDefaultsKey.transmissionPower, defaultValue: 4)
    var transmissionPower: Int
    
    static let shared = SettingRepository()
    
    private init() { }
}
