//
//  SettingPickerType.swift
//  VestellaSet
//
//  Created by 서충원 on 8/26/25.
//

import Foundation

enum SettingPickerType {
    case interval
    case power
    
    var title: String {
        switch self {
        case .interval: return "BroadCastInterval"
        case .power: return "TransmissonPower"
        }
    }
}
