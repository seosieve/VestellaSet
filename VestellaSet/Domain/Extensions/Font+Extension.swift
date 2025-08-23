//
//  Font+Extension.swift
//  VestellaSet
//
//  Created by 서충원 on 8/19/25.
//

import SwiftUI

enum Manrope {
    static func regular(size: CGFloat) -> Font {
        .custom("Manrope-Regular", size: size)
    }
    static func bold(size: CGFloat) -> Font {
        .custom("Manrope-Bold", size: size)
    }
}
