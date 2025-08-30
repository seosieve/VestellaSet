//
//  BeaconImportFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconImportFeature {
    private enum CancelID { case scannerAnimation }
    
    @Dependency(\.userDefaultsClient) var userDefaults
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State: ScannerState {
        var isRunning: Bool = false
        var isScanning: Bool = false
        var isFinished: Bool = false
        var textMessage: String = TextMessage.detectingQR
        var targetList: [String] = []
        var major: Int = 0
        var count: Int = 0
    }
    
    enum Action {
        case stopRunning
        case stopScanning
        case setTargetList([String])
        case setMajor(Int)
        case setCount(Int)
        case clickBackButton
        case clickSaveButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .stopRunning:
                state.isRunning = false
                state.isScanning = true
                state.textMessage = TextMessage.scanningQR
                return .run { send in
                    Haptic.softImpact()
                    try await Task.sleep(for: .seconds(2))
                    await send(.stopScanning)
                }
                .cancellable(id: CancelID.scannerAnimation)
            case .stopScanning:
                state.isScanning = false
                state.isFinished = true
                return .run { _ in Haptic.softImpact() }
            case .setTargetList(let targetList):
                state.targetList = targetList
                return .none
            case .setMajor(let major):
                state.major = major
                return .none
            case .setCount(let count):
                state.count = count
                return .none
            case .clickBackButton:
                return .merge(
                    .cancel(id: CancelID.scannerAnimation),
                    .run { _ in await self.dismiss() }
                )
            case .clickSaveButton:
                userDefaults.setTargetList(state.targetList)
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
