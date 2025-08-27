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
        var isSheetPresented: Bool = false
        var sheetType: SettingSheetType = .interval
    }
    
    enum Action {
        case showSheet(SettingSheetType)
        case hideSheet
        case clickBackButton
        case clickSaveButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .showSheet(let type):
                state.sheetType = type
                state.isSheetPresented = true
                return .none
            case .hideSheet:
                state.isSheetPresented = false
                return .none
            case .clickBackButton:
                return .run { _ in await self.dismiss() }
            case .clickSaveButton:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
