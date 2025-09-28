//
//  SettingInfoType.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/26/25.
//

import Foundation

enum SettingInfoType {
    case uuid
    case interval(Int)
    case power(Int)
    
    var title: String {
        switch self {
        case .uuid: "UUID"
        case .interval: "BroadcastInterval"
        case .power: "TransmissionPower"
        }
    }
    
    var value: String {
        switch self {
        case .interval(let v), .power(let v): return String(v)
        default: return ""
        }
    }
}
