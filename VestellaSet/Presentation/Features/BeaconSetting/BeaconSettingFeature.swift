//
//  BeaconSettingFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import ComposableArchitecture

@Reducer
struct BeaconSettingFeature {
    @Dependency(\.userDefaults) var userDefaults
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State {
        var isSheetPresented: Bool = false
        var isSaveEnabled: Bool = true
        var sheetType: SettingSheetType = .interval
        var uuid: String = ""
        var interval: Int = 1
        var power: Int = 1
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case showSheet(SettingSheetType)
        case hideSheet
        case selectSheetItem(Int)
        case clickBackButton
        case clickSaveButton
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.isSaveEnabled = isValidUUID(state.uuid)
                return .none
                
            case .onAppear:
                state.uuid = userDefaults.uuid()
                state.interval = userDefaults.broadcastInterval()
                state.power = userDefaults.transmissionPower()
                return .none

            case .showSheet(let type):
                state.sheetType = type
                state.isSheetPresented = true
                return .none

            case .hideSheet:
                state.isSheetPresented = false
                return .none

            case .selectSheetItem(let index):
                switch state.sheetType {
                case .interval: state.interval = index
                case .power: state.power = index
                default: break
                }
                state.isSheetPresented = false
                return .none

            case .clickBackButton:
                return .run { _ in await self.dismiss() }

            case .clickSaveButton:
                userDefaults.setUuid(state.uuid)
                userDefaults.setBroadcastInterval(state.interval)
                userDefaults.setTransmissionPower(state.power)
                return .run { _ in await self.dismiss() }
            }
        }
    }
    
    private func isValidUUID(_ uuid: String) -> Bool {
        // 8-4-4-4-12, 숫자/소문자만 허용
        let pattern = #"^[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}$"#
        return uuid.range(of: pattern, options: .regularExpression) != nil
    }
}
