//
//  BeaconSettingFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconSettingFeature {
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State {
        var isPicking: Bool = false
        var pickerType: SettingPickerType = .interval
    }
    
    enum Action {
        case startPicking(SettingPickerType)
        case stopPicking
        case clickBackButton
        case clickSaveButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startPicking(let type):
                state.pickerType = type
                state.isPicking = true
                return .none
            case .stopPicking:
                state.isPicking = false
                return .none
            case .clickBackButton:
                return .run { _ in await self.dismiss() }
            case .clickSaveButton:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
