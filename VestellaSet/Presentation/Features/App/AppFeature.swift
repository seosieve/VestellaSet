//
//  AppFeature.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    @Reducer
    enum Path {
        case beaconDashBoard(BeaconDashBoardFeature)
        case beaconImport(BeaconImportFeature)
        case beaconSetting(BeaconSettingFeature)
        case beaconScanner(BeaconScannerFeature)
        case beaconEditor(BeaconEditorFeature)
    }
    
    @ObservableState
    struct State {
        var navigationPath = StackState<Path.State>()
    }
    
    enum Action {
        case navigationPath(StackActionOf<Path>)
        case onAppear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.navigationPath.append(.beaconDashBoard(BeaconDashBoardFeature.State()))
                return .none
                
            case .navigationPath(.element(id: _, action: .beaconDashBoard(.clickImportButton))):
                state.navigationPath.append(.beaconImport(BeaconImportFeature.State()))
                return .none
                
            case .navigationPath(.element(id: _, action: .beaconDashBoard(.clickSettingButton))):
                state.navigationPath.append(.beaconSetting(BeaconSettingFeature.State()))
                return .none
                
            case .navigationPath(.element(id: _, action: .beaconDashBoard(.clickTargetCell(let target)))):
                state.navigationPath.append(.beaconScanner(BeaconScannerFeature.State(target: target)))
                return .none
                
            case .navigationPath(.element(id: _, action: .beaconScanner(.navigateToEditor(let target, let identifier)))):
                state.navigationPath.append(.beaconEditor(BeaconEditorFeature.State(target: target, identifier: identifier)))
                return .none
                
            case .navigationPath(.element(id: _, action: .beaconEditor(.navigateToScanner(let target)))):
                state.navigationPath.removeLast(2)
                state.navigationPath.append(.beaconScanner(BeaconScannerFeature.State(target: target)))
                return .none
                
            case .navigationPath(.element(id: _, action: .beaconEditor(.navigateToDashBoard))):
                state.navigationPath.removeLast(2)
                guard let id = state.navigationPath.ids.last else { return .none }
                return .send(.navigationPath(.element(id: id, action: .beaconDashBoard(.refreshData))))
                
            default:
                return .none
            }
        }
        .forEach(\.navigationPath, action: \.navigationPath)
    }
}
