//
//  Constant.swift
//  VestellaSet
//
//  Created by 서충원 on 8/12/25.
//

import Foundation

enum Spacing {
    static let zero: CGFloat = 0
    static let s4: CGFloat = 4
    static let s8: CGFloat = 8
    static let s12: CGFloat = 12
    static let s16: CGFloat = 16
    static let s20: CGFloat = 20
    static let s24: CGFloat = 24
    static let s28: CGFloat = 28
    static let s32: CGFloat = 32
    static let s36: CGFloat = 36
    static let s40: CGFloat = 40
    static let s44: CGFloat = 44
    static let s52: CGFloat = 52
    static let s64: CGFloat = 64
    static let s72: CGFloat = 72
    static let s100: CGFloat = 100
}

enum Radius {
    static let zero: CGFloat = 0
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

enum TextMessage {
    static let detectingBeacon: String = "Detecting the Beacon"
    static let detectingMAC: String = "Detecting the MAC address"
    static let detectingQR: String = "Detecting the QR code"
    static let scanningQR: String = "Scanning the QR code"
    static let enterUUID: String = "Enter your 32-character UUID"
    static let enterKeyword: String = "Search by UUID, Major, or Minor"
    static let emptyList: String = "No beacons in your list"
}
