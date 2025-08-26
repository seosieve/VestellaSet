//
//  Haptic.swift
//  VestellaSet
//
//  Created by 서충원 on 8/26/25.
//

import UIKit

enum Haptic {
    static func softImpact() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
}
