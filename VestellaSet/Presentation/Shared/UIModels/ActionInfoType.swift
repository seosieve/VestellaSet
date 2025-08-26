//
//  ActionInfoType.swift
//  VestellaSet
//
//  Created by 서충원 on 8/26/25.
//

import Foundation

enum ActionInfoType {
    case save
    
    var title: String {
        switch self {
        case .save: return "Save"
        }
    }
}
