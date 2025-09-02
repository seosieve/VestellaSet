//
//  BeaconInfoType.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import Foundation

enum BeaconInfoType {
    case major(MinewBeacon?)
    case minor(MinewBeacon?)
    
    var title: String {
        switch self {
        case .major: return "major"
        case .minor: return "minor"
        }
    }
    
    var value: String {
        switch self {
        case .major(let beacon): return String(beacon?.major ?? 0)
        case .minor(let beacon): return String(beacon?.minor ?? 0)
        }
    }
}
