//
//  SettingInfoType.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/26/25.
//

import Foundation

enum SettingInfoType {
    case uuid(String)
    case interval(Int)
    case power(Int)
    
    var title: String {
        switch self {
        case .uuid: return "UUID"
        case .interval: return "BroadCastInterval"
        case .power: return "TransmissonPower"
        }
    }
    
    var value: String {
        switch self {
        case .uuid(let v): return v
        case .interval(let v), .power(let v): return String(v)
        }
    }
}
