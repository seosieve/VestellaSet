//
//  BeaconScannerFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconScannerFeature {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State: ScannerState {
        var isScanning: Bool = false
        var isFinished: Bool = false
        var textMessage: String = TextMessage.detectingMAC
        var macAddress: String = ""
    }
    
    enum Action {
        case startScanning
        case stopScanning
        case setMacAddress(String)
        case navigateToEditor
        case clickBackButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startScanning:
                state.isScanning = true
                return .none
            case .stopScanning:
                state.isScanning = false
                state.isFinished = true
                return .none
            case .setMacAddress(let macAddress):
                state.macAddress = macAddress
                return .run { send in
                    Haptic.softImpact()
                    try await Task.sleep(for: .seconds(0.6))
                    await send(.navigateToEditor)
                }
            case .navigateToEditor:
                return .none
            case .clickBackButton:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
