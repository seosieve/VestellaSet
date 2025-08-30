//
//  ScannerState.swift
//  VestellaSet
//
//  Created by 서충원 on 8/30/25.
//

import ComposableArchitecture

protocol ScannerState: ObservableState {
    var isScanning: Bool { get }
    var isFinished: Bool { get }
    var textMessage: String { get }
}
