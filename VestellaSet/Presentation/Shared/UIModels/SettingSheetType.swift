//
//  SettingSheetType.swift
//  VestellaSet
//
//  Created by 서충원 on 8/26/25.
//

import Foundation

enum SettingSheetType {
    case interval
    case power
    
    var title: String {
        switch self {
        case .interval: return "BroadcastInterval"
        case .power: return "TransmissionPower"
        }
    }
    
    var item: [SheetItem] {
        switch self {
        case .interval:
            return [
                SheetItem(index: 1, value: "100ms"),
                SheetItem(index: 2, value: "200ms"),
                SheetItem(index: 3, value: "300ms"),
                SheetItem(index: 4, value: "400ms"),
                SheetItem(index: 5, value: "500ms"),
                SheetItem(index: 6, value: "600ms"),
                SheetItem(index: 7, value: "700ms"),
                SheetItem(index: 8, value: "800ms"),
                SheetItem(index: 9, value: "900ms"),
                SheetItem(index: 10, value: "1000ms"),
            ]
        case .power:
            return [
                SheetItem(index: 1, value: "-20dBm"),
                SheetItem(index: 2, value: "-16dBm"),
                SheetItem(index: 3, value: "-12dBm"),
                SheetItem(index: 4, value: "-8dBm"),
                SheetItem(index: 5, value: "-4dBm"),
                SheetItem(index: 6, value: "0dBm"),
                SheetItem(index: 7, value: "4dBm"),
            ]
        }
    }
    
    var height: CGFloat {
        switch self {
        case .interval, .power: return CGFloat(self.item.count) * Sheet.itemHeight
        }
    }
    
    struct SheetItem: Identifiable {
        let id = UUID()
        let index: Int
        let value: String
    }
}
