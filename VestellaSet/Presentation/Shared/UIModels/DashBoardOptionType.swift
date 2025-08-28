//
//  DashBoardOptionType.swift
//  VestellaSet
//
//  Created by 서충원 on 8/28/25.
//

import Foundation

enum DashBoardOptionType: CaseIterable {
    case all
    case completed
    case incomplete
    
    var title: String {
        switch self {
        case .all: return "All"
        case .completed: return "Completed"
        case .incomplete: return "Incomplete"
        }
    }
}
