//
//  BeaconInfoType.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import Foundation

enum BeaconInfoType {
    case currentMajor(MinewBeacon?)
    case currentMinor(MinewBeacon?)
    case targetMajor(String)
    case targetMinor(String)
    
    var title: String {
        switch self {
        case .currentMajor, .targetMajor: return "major"
        case .currentMinor, .targetMinor: return "minor"
        }
    }
    
    var value: String {
        switch self {
        case .currentMajor(let beacon): return String(beacon?.major ?? 0)
        case .currentMinor(let beacon): return String(beacon?.minor ?? 0)
        case .targetMajor(let beacon): return String(beacon.split(separator: " ")[0])
        case .targetMinor(let beacon): return String(beacon.split(separator: " ")[1])
        }
    }
}
