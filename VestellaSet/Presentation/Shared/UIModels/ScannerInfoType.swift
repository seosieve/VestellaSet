//
//  ScannerInfoType.swift
//  VestellaSet
//
//  Created by 서충원 on 8/23/25.
//

import Foundation

enum ScannerInfoType {
    case major(Int)
    case count(Int)
    
    var title: String {
        switch self {
        case .major: return "Major"
        case .count: return "Count"
        }
    }
    
    var value: Int {
        switch self {
        case .major(let v), .count(let v): return v
        }
    }
}
