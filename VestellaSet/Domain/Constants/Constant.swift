//
//  Constant.swift
//  VestellaSet
//
//  Created by 서충원 on 8/12/25.
//

import Foundation

enum Spacing {
    static let s4: CGFloat = 4
    static let s8: CGFloat = 8
    static let s12: CGFloat = 12
    static let s16: CGFloat = 16
    static let s20: CGFloat = 20
    static let s24: CGFloat = 24
    static let s28: CGFloat = 28
    static let s32: CGFloat = 32
}

enum Radius {
    static let s4: CGFloat = 4
    static let s8: CGFloat = 8
    static let s12: CGFloat = 12
    static let s16: CGFloat = 16
    static let s20: CGFloat = 20
    static let s24: CGFloat = 24
    static let s28: CGFloat = 28
    static let s32: CGFloat = 32
}

enum Scanner {
    static let lineWidth: CGFloat = 4
    static let gradientHeight: CGFloat = 60
    static let edgeLength: CGFloat = 60
}

enum Sheet {
    static let itemHeight: CGFloat = 48
}

enum Effect {
    static let id: String = "pickerHighlight"
}

enum TextMessage {
    static let detecting: String = "Detecting the QR code"
    static let scanning: String = "Scanning the QR code"
}
