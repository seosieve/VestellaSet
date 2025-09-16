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
        var isScanning: Bool = true
        var isFinished: Bool = false
        var target: String
        var identifier: String = ""
        var textMessage: String = TextMessage.detectingMAC
    }
    
    enum Action {
        case stopScanning
        case setIdentifier(String)
        case navigateToEditor(String, String)
        case clickBackButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .stopScanning:
                state.isScanning = false
                state.isFinished = true
                return .none
            case .setIdentifier(let identifier):
                state.identifier = identifier
                let target = state.target
                return .run { send in
                    Haptic.softImpact()
                    try await Task.sleep(for: .seconds(0.6))
                    await send(.navigateToEditor(target, identifier))
                }
            case .navigateToEditor:
                return .none
            case .clickBackButton:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
