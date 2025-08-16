//
//  UserDefaultsKey.swift
//  VestellaSet
//
//  Created by 서충원 on 8/12/25.
//

import Foundation

enum UserDefaultsKey {
    static let prefix = "vestella"
    static let uuid = "\(prefix)_UUID"
    static let broadcastInterval = "\(prefix)_broadcastInterval"
    static let transmissionPower = "\(prefix)_transmissionPower"
    static let targetList = "\(prefix)_targetList"
}
